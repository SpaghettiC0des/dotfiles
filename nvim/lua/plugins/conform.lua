-- Custom setup: ESLint for fix on save + Prettier for formatting (without eslint-plugin-prettier)
return {
  -- Configure conform for Prettier formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
      },
    },
  },
  -- Configure nvim-lint for ESLint linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
      },
    },
  },
  -- Configure ESLint LSP for auto-fixing (import/order, etc.)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
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
        end,
      },
    },
  },
}
