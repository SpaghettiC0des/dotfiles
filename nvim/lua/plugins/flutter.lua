-- requires dart/flutter to be installed
return {
  -- recommended = {
  --   ft = "dart",
  --   root = { "pubspec.yaml" },
  -- },
  {
    "akinsho/flutter-tools.nvim",
    -- ft = "dart",
    -- lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = true, --
          },
        },
        debugger = {
          enabled = true,
          register_configurations = function(_)
            -- require("dap").configurations.dart = {}
            require("dap.ext.vscode").load_launchjs()
          end,
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "dart" } },
  },
  -- { "nvimtools/none-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, nls.builtins.formatting.dart_format)
  --   end,
  -- },
}
