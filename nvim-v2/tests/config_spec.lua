-- Integration checks against the active configuration and installed plugins.
local config = require("lazy.core.config")
local plugin = require("lazy.core.plugin")
local function opts(name)
  return plugin.values(assert(config.plugins[name], name .. " missing"), "opts", false)
end

assert(not config.plugins["markview.nvim"], "Only one Markdown renderer should be enabled")
assert(config.plugins["render-markdown.nvim"])
assert(not config.plugins["window-picker"]._.loaded, "Window picker should load on demand")
assert(not config.plugins["package-info.nvim"]._.loaded, "Package checks should load on demand")
assert(config.plugins["smart-splits.nvim"]._.loaded, "WezTerm integration must load at startup")
assert(opts("package-info.nvim").autostart == false)

local snacks = opts("snacks.nvim")
assert(snacks.explorer.enabled and snacks.picker.enabled and snacks.bigfile.enabled)
assert(snacks.picker.sources.explorer.layout.layout.position == "right")

local lsp = opts("nvim-lspconfig")
assert(lsp.servers.oxfmt.enabled == false)
assert(not (lsp.servers.vtsls.handlers or {})["textDocument/publishDiagnostics"])
assert(lsp.servers.basedpyright.enabled ~= false, "Preserve the selected Python server")

local root = vim.fn.tempname()
vim.fn.mkdir(root, "p")
vim.fn.writefile({ '{"devDependencies":{"@biomejs/biome":"*","prettier":"*"}}' }, root .. "/package.json")
vim.fn.writefile({ "{}" }, root .. "/biome.json")
local buf = vim.api.nvim_create_buf(false, true)
local ok, err = xpcall(function()
  local conform = opts("conform.nvim")
  for _, case in ipairs({
    { "index.ts", "typescript", { "biome" } },
    { "README.md", "markdown", { "prettier", "markdownlint-cli2", "markdown-toc" } },
    { "page.mdx", "markdown.mdx", { "prettier", "markdownlint-cli2", "markdown-toc" } },
    { "config.yaml", "yaml", { "prettier" } },
  }) do
    vim.api.nvim_buf_set_name(buf, root .. "/" .. case[1])
    vim.bo[buf].filetype = case[2]
    local actual = conform.formatters_by_ft[case[2]](buf)
    assert(vim.deep_equal(actual, case[3]), case[2] .. ": " .. vim.inspect(actual))
  end
  assert(type(conform.formatters["markdown-toc"].condition) == "function")
  assert(type(conform.formatters["markdownlint-cli2"].condition) == "function")

  require("lazy").load({ plugins = { "conform.nvim", "flash.nvim", "render-markdown.nvim" } })
  assert(require("conform").get_formatter_config("biome", buf).command)

  vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
  for _, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>", "<C-\\>" }) do
    assert(vim.fn.maparg(key, "n") ~= "", key .. " missing")
  end
  assert(not config.plugins["window-picker"]._.loaded)
  assert(not config.plugins["package-info.nvim"]._.loaded)
end, debug.traceback)
vim.api.nvim_buf_delete(buf, { force = true })
vim.fn.delete(root, "rf")
assert(ok, err)
print("config: plugin, formatter, and keymap checks passed")
