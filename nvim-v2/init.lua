-- bootstrap lazy.nvim, LazyVim and your plugins
local function use_neovim_build_runtime()
  local source_root = (vim.v.progpath or ""):match("^(.*)/build/bin/nvim$")
  if not source_root then
    return
  end

  local uv = vim.uv or vim.loop
  local runtime = source_root .. "/runtime"
  local current_runtime = vim.env.VIMRUNTIME or ""

  if uv.fs_stat(runtime .. "/lua/vim/log.lua") and not uv.fs_stat(current_runtime .. "/lua/vim/log.lua") then
    vim.env.VIMRUNTIME = runtime
    vim.opt.runtimepath:prepend(runtime)
    package.path = runtime .. "/lua/?.lua;" .. runtime .. "/lua/?/init.lua;" .. package.path
  end
end

use_neovim_build_runtime()

require("config.lazy")
