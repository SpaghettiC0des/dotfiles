if true then
  return {
    { "mason-org/mason.nvim", version = "1.11.0" },
    { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
  }
end
return {
  {
    -- Ensure C/C++ debugger is installed
    "williamboman/mason.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "codelldb",
        "clangd",
        "js-debug-adapter",
        "typescript-language-server",
        "graphql-language-service-cli",
      },
    },
  },
}
