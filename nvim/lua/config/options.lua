-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- LazyVim Recipe: ESLint for fix on save + Prettier for formatting
vim.g.lazyvim_eslint_auto_format = true
vim.g.lazyvim_prettier_needs_config = true -- Not needed with custom config

-- Performance: Disable LSP logging to reduce overhead
-- Use "off", "error", "warn", "info", "debug", "trace" (default is "warn")
-- Change to "debug" or "trace" only when troubleshooting LSP issues
vim.lsp.set_log_level("off")

-- Additional performance optimizations
-- Reduce the frequency of CursorHold events (default is 4000ms)
vim.opt.updatetime = 250

-- Disable some built-in providers for better startup time (if you don't use them)
-- vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_node_provider = 0
