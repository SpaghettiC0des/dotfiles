-- Configure formatter priority: oxfmt (LSP) > biome > prettier
--
-- oxfmt: use LSP server (stays in memory, instant formatting)
--        NOT the CLI via conform (known 50x slowdown bug on already-formatted files)
-- biome: conform, only when biome.json exists
-- prettier: conform fallback, prefers local node_modules
return {
  -- Re-enable oxfmt LSP (LazyVim oxc extra disables it in favor of conform CLI)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxfmt = { enabled = true },
        graphql = {},
      },
    },
  },

  -- Remove oxfmt from conform (let LSP handle it), keep biome + prettier, add missing formatters
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}

      -- Strip oxfmt from conform — LSP handles it
      for ft, formatters in pairs(opts.formatters_by_ft) do
        opts.formatters_by_ft[ft] = vim.tbl_filter(function(f)
          return f ~= "oxfmt"
        end, formatters)
      end

      -- TypeScript / JavaScript priority
      -- Note: biome-check runs if biome.json is found, otherwise fallback to prettier
      opts.formatters_by_ft.javascript = { "biome-check", "prettier" }
      opts.formatters_by_ft.typescript = { "biome-check", "prettier" }
      opts.formatters_by_ft.javascriptreact = { "biome-check", "prettier" }
      opts.formatters_by_ft.typescriptreact = { "biome-check", "prettier" }

      -- Shell priority
      opts.formatters_by_ft.sh = { "shfmt" }

      -- SQL priority
      opts.formatters_by_ft.sql = { "sqlfluff", "pg_format" }

      -- GraphQL priority
      opts.formatters_by_ft.graphql = { "prettier" }

      -- biome: only when biome.json exists
      opts.formatters["biome-check"] = opts.formatters["biome-check"] or {}
      opts.formatters["biome-check"].require_cwd = true

      -- prettier: prefer local node_modules version, but fallback to global if local fails
      opts.formatters.prettier = opts.formatters.prettier or {}
      opts.formatters.prettier.command = require("conform.util").from_node_modules("prettier")

      return opts
    end,
  },
}
