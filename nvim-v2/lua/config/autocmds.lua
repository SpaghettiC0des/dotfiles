-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local js_tools_group = vim.api.nvim_create_augroup("project_js_tools", { clear = true })

local function clear_js_tools_cache()
  require("config.js_tools").clear_cache()
end

vim.api.nvim_create_autocmd("BufWritePost", {
  group = js_tools_group,
  pattern = {
    "package.json",
    "biome.json",
    "biome.jsonc",
    ".oxlintrc.json",
    ".oxlintrc.jsonc",
    "oxlint.config.*",
    ".oxfmtrc.json",
    ".oxfmtrc.jsonc",
    "oxfmt.config.*",
    ".prettierrc*",
    "prettier.config.*",
    ".eslintrc*",
    "eslint.config.*",
  },
  callback = clear_js_tools_cache,
  desc = "Refresh project JavaScript tool selection",
})

vim.api.nvim_create_autocmd("DirChanged", {
  group = js_tools_group,
  callback = clear_js_tools_cache,
  desc = "Refresh project JavaScript tools after changing directory",
})
