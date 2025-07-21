-- Custom setup: ESLint for fix on save + Prettier for formatting (without eslint-plugin-prettier)
return {
  -- Configure conform for dynamic formatting (Biome if available, otherwise Prettier)
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Check if biome.json exists in current working directory or any parent directory
      local function has_biome_config()
        local current_dir = vim.fn.getcwd()
        local config_files = { "biome.json", "biome.jsonc" }
        
        -- Check current directory and walk up the tree
        local dir = current_dir
        while dir ~= "/" do
          for _, file in ipairs(config_files) do
            if vim.fn.filereadable(dir .. "/" .. file) == 1 then
              return true
            end
          end
          dir = vim.fn.fnamemodify(dir, ":h")
        end
        return false
      end
      
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      
      -- Dynamic formatter selection based on Biome availability
      if has_biome_config() then
        -- Biome is available - let it handle JS/TS/JSON files
        -- Don't set formatters for these file types, let Biome extra handle them
      else
        -- No Biome config - use Prettier for JS/TS/JSON files
        opts.formatters_by_ft.javascript = { "prettier" }
        opts.formatters_by_ft.typescript = { "prettier" }
        opts.formatters_by_ft.javascriptreact = { "prettier" }
        opts.formatters_by_ft.typescriptreact = { "prettier" }
        opts.formatters_by_ft.json = { "prettier" }
        opts.formatters_by_ft.jsonc = { "prettier" }
      end
      
      -- Always use Prettier for files Biome doesn't handle well
      opts.formatters_by_ft.vue = { "prettier" }
      opts.formatters_by_ft.css = { "prettier" }
      opts.formatters_by_ft.scss = { "prettier" }
      opts.formatters_by_ft.less = { "prettier" }
      opts.formatters_by_ft.html = { "prettier" }
      opts.formatters_by_ft.yaml = { "prettier" }
      opts.formatters_by_ft.markdown = { "prettier" }
      opts.formatters_by_ft.graphql = { "prettier" }
      
      return opts
    end,
  },
  -- Configure nvim-lint for ESLint linting (only if eslint is available)
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Check if eslint is available in the project
      local function has_eslint()
        -- Check for eslint in node_modules/.bin
        if vim.fn.executable("npx") == 1 then
          local result = vim.fn.system("npx -q eslint --version 2>/dev/null")
          if vim.v.shell_error == 0 then
            return true
          end
        end
        
        -- Check for global eslint
        if vim.fn.executable("eslint") == 1 then
          return true
        end
        
        -- Check for eslint config files
        local config_files = {
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
        }
        
        for _, file in ipairs(config_files) do
          if vim.fn.filereadable(file) == 1 then
            return true
          end
        end
        
        -- Check package.json for eslint dependency
        if vim.fn.filereadable("package.json") == 1 then
          local package_json = vim.fn.readfile("package.json")
          local content = table.concat(package_json, "\n")
          if content:match('"eslint"') then
            return true
          end
        end
        
        return false
      end
      
      opts.linters_by_ft = opts.linters_by_ft or {}
      if has_eslint() then
        opts.linters_by_ft.javascript = { "eslint" }
        opts.linters_by_ft.typescript = { "eslint" }
        opts.linters_by_ft.javascriptreact = { "eslint" }
        opts.linters_by_ft.typescriptreact = { "eslint" }
      end
      
      return opts
    end,
  },
  -- Configure ESLint LSP for auto-fixing (only if eslint is available)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Check if eslint should be enabled
      local function should_enable_eslint()
        -- Check for eslint config files
        local config_files = {
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
        }
        
        for _, file in ipairs(config_files) do
          if vim.fn.filereadable(file) == 1 then
            return true
          end
        end
        
        -- Check package.json for eslint dependency
        if vim.fn.filereadable("package.json") == 1 then
          local package_json = vim.fn.readfile("package.json")
          local content = table.concat(package_json, "\n")
          if content:match('"eslint"') then
            return true
          end
        end
        
        return false
      end
      
      opts.servers = opts.servers or {}
      opts.setup = opts.setup or {}
      
      if should_enable_eslint() then
        opts.servers.eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        }
        
        opts.setup.eslint = function()
          -- Register ESLint formatter for auto-fixing
          LazyVim.lsp.on_attach(function(client, bufnr)
            if client.name == "eslint" then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.cmd("EslintFixAll")
                end,
              })
            end
          end)
        end
      end
      
      return opts
    end,
  },
}
