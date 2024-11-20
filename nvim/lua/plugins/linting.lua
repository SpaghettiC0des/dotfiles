return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   optional = true,
  -- opts = function(_, opts)
  --   local nls = require("null-ls")
  --   opts.sources = opts.sources or {}
  --   table.insert(opts.sources, nls.builtins.formatting.prettier)
  -- end,
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   ---@param opts ConformOpts
  --   opts = function(_, opts)
  --     opts.formatters_by_ft = opts.formatters_by_ft or {}
  --     for _, ft in ipairs(supported) do
  --       opts.formatters_by_ft[ft] = { "prettier" }
  --     end
  --
  --     opts.formatters = opts.formatters or {}
  --     opts.formatters.prettier = {
  --       condition = function(_, ctx)
  --         return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
  --       end,
  --     }
  --   end,
  -- },
}
