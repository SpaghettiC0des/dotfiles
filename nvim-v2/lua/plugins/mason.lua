return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- LSP
        "bash-language-server",
        "clangd",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "eslint_d",
        "graphql-language-service-cli",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "sqlfluff",
        "tailwindcss-language-server",
        "taplo",
        "vtsls",
        "yaml-language-server",

        -- Formatters / Linters
        "biome",
        "hadolint",
        "markdown-toc",
        "markdownlint-cli2",
        "oxlint",
        "oxfmt",
        "pgformatter",
        "prettier",
        "shfmt",
        "stylua",
      })
    end,
  },
}
