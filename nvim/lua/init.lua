local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
  {
    "phaazon/hop.nvim",
    branch = 'v2',
    config = function() 
      local hop = require("hop")
      local keymap = vim.api.nvim_set_keymap
      local directions = require('hop.hint').HintDirection
      local opts = { 
        silent = true, 
        noremap=true,
        callback=nil,
        desc=nil,
      }
      local bindings = {
        { 
          mode = 'n',
          mapping = ';w', 
          desc = '',
          func = hop.hint_words,
        },
        { 
          mode = 'n',
          mapping = ';c', 
          desc = '',
          func = function() hop.hint_words({ current_line_only = true }) end
        },
      }

      hop.setup()

      table.foreach(bindings, function(idx, binding) 
        opts.callback = binding.func
        opts.desc = binding.desc
        keymap(binding.mode, binding.mapping, '', opts)
      end)
    end
  },
  "tpope/vim-surround",
  "tpope/vim-repeat",
}

require("lazy").setup(plugins)
