local web_filetypes = {
  "astro",
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "mdx",
  "scss",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

---@param server "biome"|"oxlint"|"eslint"
---@return fun(bufnr: number, on_dir: fun(root_dir: string))
local function linter_root(server)
  return function(bufnr, on_dir)
    local root = require("config.js_tools").linter_root(server, bufnr)
    if root then
      on_dir(root)
    end
  end
end

---@param server table
local function disable_lsp_formatting(server)
  local on_attach = server.on_attach
  server.on_attach = function(client, bufnr)
    if on_attach then
      on_attach(client, bufnr)
    end
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      for _, server in ipairs({ "biome", "oxlint", "eslint" }) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].root_dir = linter_root(server)
      end

      opts.servers.eslint.settings = opts.servers.eslint.settings or {}
      opts.servers.eslint.settings.format = false
      disable_lsp_formatting(opts.servers.biome)

      opts.servers.vtsls = opts.servers.vtsls or {}
      disable_lsp_formatting(opts.servers.vtsls)

      opts.servers.graphql = opts.servers.graphql or {}
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      for _, ft in ipairs(web_filetypes) do
        opts.formatters_by_ft[ft] = function(bufnr)
          local formatter = require("config.js_tools").formatter(bufnr, ft)
          local selected = formatter and { formatter } or {}
          if ft == "markdown" or ft == "markdown.mdx" then
            vim.list_extend(selected, { "markdownlint-cli2", "markdown-toc" })
          end
          return selected
        end
      end

      opts.formatters_by_ft.sql = { "sqlfluff", "pg_format", stop_after_first = true }
    end,
  },
}
