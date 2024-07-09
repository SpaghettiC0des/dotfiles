return {
  {
    -- Ensure C/C++ debugger is installed
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "codelldb", "clangd", "js-debug-adapter", "typescript-language-server" } },
  },
}
