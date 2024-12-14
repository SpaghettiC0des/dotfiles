return {
  -- {
  --   "chrisgrieser/nvim-spider",
  --   lazy = true,
  --   keys = {
  --     {
  --       "e",
  --       "<cmd>lua require('spider').motion('e')<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --     {
  --       "w",
  --       "<cmd>lua require('spider').motion('w')<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --     {
  --       "b",
  --       "<cmd>lua require('spider').motion('b')<CR>",
  --       mode = { "n", "o", "x" },
  --     },
  --   },
  -- },
  -- {
  --   "glacambre/firenvim",
  --
  --   -- Lazy load firenvim
  --   -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  --   lazy = not vim.g.started_by_firenvim,
  --   build = function()
  --     vim.fn["firenvim#install"](0)
  --   end,
  -- },
  -- {
  --   "olrtg/nvim-emmet",
  --   config = function()
  --     vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
  --   end,
  -- },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      require("smart-splits").setup({
        ignored_filetypes = {},
      })
    end,
  },
  {
    "tadaa/vimade",
    -- default opts (you can partially set these or configure them however you like)
    opts = {
      -- Recipe can be any of 'default', 'minimalist', 'duo', and 'ripple'
      -- Set animate = true to enable animations on any recipe.
      -- See the docs for other config options.
      recipe = { "minimalist", { animate = false } },
      ncmode = "buffers", -- use 'windows' to fade inactive windows
      fadelevel = 0.5, -- any value between 0 and 1. 0 is hidden and 1 is opaque.
      tint = {
        bg = { rgb = { 0, 0, 0 }, intensity = 0.4 }, -- adds 30% black to background
        -- fg = { rgb = { 0, 255, 0 }, intensity = 0.3 }, -- adds 30% blue to foreground
        -- fg = { rgb = { 120, 120, 120 }, intensity = 1 }, -- all text will be gray
        -- sp = {rgb={255,0,0}, intensity=0.5}, -- adds 50% red to special characters
        -- you can also use functions for tint or any value part in the tint object
        -- to create window-specific configurations
        -- see the `Tinting` section of the README for more details.
      },

      -- Changes the real or theoretical background color. basebg can be used to give
      -- transparent terminals accurating dimming.  See the 'Preparing a transparent terminal'
      -- section in the README.md for more info.
      -- basebg = [23,23,23],
      basebg = "",

      -- prevent a window or buffer from being styled. You
      blocklist = {
        default = {
          buf_opts = { buftype = { "prompt", "terminal", "neo-tree" } },
          win_config = { relative = true },
          -- buf_name = {'name1','name2', name3'},
          -- buf_vars = { variable = {'match1', 'match2'} },
          -- win_opts = { option = {'match1', 'match2' } },
          -- win_vars = { variable = {'match1', 'match2'} },
        },
        -- any_rule_name1 = {
        --   buf_opts = {}
        -- },
        -- only_behind_float_windows = {
        --   buf_opts = function(win, current)
        --     if (win.win_config.relative == '')
        --       and (current and current.win_config.relative ~= '') then
        --         return false
        --     end
        --     return true
        --   end
        -- },
      },
      -- Link connects windows so that they style or unstyle together.
      -- Properties are matched against the active window. Same format as blocklist above
      link = {},
      groupdiff = true, -- links diffs so that they style together
      groupscrollbind = false, -- link scrollbound windows so that they style together.

      -- enable to bind to FocusGained and FocusLost events. This allows fading inactive
      -- tmux panes.
      enablefocusfading = false,

      -- when nohlcheck is disabled the highlight tree will always be recomputed. You may
      -- want to disable this if you have a plugin that creates dynamic highlights in
      -- inactive windows. 99% of the time you shouldn't need to change this value.
      nohlcheck = true,
    },
  },
  -- {
  -- "s1n7ax/nvim-window-picker",
  -- name = "window-picker",
  -- event = "VeryLazy",
  -- version = "2.*",
  -- opts = {
  -- hint = "floating-big-letter",
  -- selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- filter_rules = {
  --   include_current_win = false,
  --   autoselect_one = true,
  --   -- filter using buffer options
  --   bo = {
  --     -- if the file type is one of following, the window will be ignored
  --     filetype = { "neo-tree", "neo-tree-popup", "notify", "noice" },
  --     -- if the buffer type is one of following, the window will be ignored
  --     buftype = { "terminal", "quickfix" },
  --   },
  -- },
  --   },
  -- },
  -- startup
  -- {
  --   "goolord/alpha-nvim",
  --   enabled = false,
  --   opts = function()
  --     local dashboard = require("alpha.themes.dashboard")
  --     local logo1 = [[
  -- ██╗   ██╗███████╗     ██████╗ ██████╗ ██████╗ ███████╗
  -- ██║   ██║██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝
  -- ██║   ██║███████╗    ██║     ██║   ██║██║  ██║█████╗
  -- ╚██╗ ██╔╝╚════██║    ██║     ██║   ██║██║  ██║██╔══╝
  --  ╚████╔╝ ███████║    ╚██████╗╚██████╔╝██████╔╝███████╗
  --   ╚═══╝  ╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
  --       ]]
  --     local logo2 = [[
  -- ██╗  ██╗ █████╗ ██████╗ ██╗         ██╗   ██╗██╗███╗   ███╗
  -- ██║ ██╔╝██╔══██╗██╔══██╗██║         ██║   ██║██║████╗ ████║
  -- █████╔╝ ███████║██████╔╝██║         ██║   ██║██║██╔████╔██║
  -- ██╔═██╗ ██╔══██║██╔══██╗██║         ╚██╗ ██╔╝██║██║╚██╔╝██║
  -- ██║  ██╗██║  ██║██║  ██║███████╗     ╚████╔╝ ██║██║ ╚═╝ ██║
  -- ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝
  --       ]]
  --     local logo3 = [[
  -- ███████╗██████╗  █████╗  ██████╗ ██╗  ██╗███████╗████████╗████████╗██╗ ██████╗ ██████╗ ██████╗ ███████╗███████╗
  -- ██╔════╝██╔══██╗██╔══██╗██╔════╝ ██║  ██║██╔════╝╚══██╔══╝╚══██╔══╝██║██╔════╝██╔═████╗██╔══██╗██╔════╝██╔════╝
  -- ███████╗██████╔╝███████║██║  ███╗███████║█████╗     ██║      ██║   ██║██║     ██║██╔██║██║  ██║█████╗  ███████╗
  -- ╚════██║██╔═══╝ ██╔══██║██║   ██║██╔══██║██╔══╝     ██║      ██║   ██║██║     ████╔╝██║██║  ██║██╔══╝  ╚════██║
  -- ███████║██║     ██║  ██║╚██████╔╝██║  ██║███████╗   ██║      ██║   ██║╚██████╗╚██████╔╝██████╔╝███████╗███████║
  -- ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝   ╚═╝      ╚═╝   ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝
  -- 🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝🍝
  --       ]]
  --     local logo4 = [[
  --        __/\\\________/\\\__________________________________/\\\\\\______/\\\________/\\\___/\\\\\\\\\\\___/\\\\____________/\\\\_
  --         _\/\\\_____/\\\//__________________________________\////\\\_____\/\\\_______\/\\\__\/////\\\///___\/\\\\\\________/\\\\\\_
  --          _\/\\\__/\\\//________________________________________\/\\\_____\//\\\______/\\\_______\/\\\______\/\\\//\\\____/\\\//\\\_
  --           _\/\\\\\\//\\\_______/\\\\\\\\\______/\\/\\\\\\\______\/\\\______\//\\\____/\\\________\/\\\______\/\\\\///\\\/\\\/_\/\\\_
  --            _\/\\\//_\//\\\_____\////////\\\____\/\\\/////\\\_____\/\\\_______\//\\\__/\\\_________\/\\\______\/\\\__\///\\\/___\/\\\_
  --             _\/\\\____\//\\\______/\\\\\\\\\\___\/\\\___\///______\/\\\________\//\\\/\\\__________\/\\\______\/\\\____\///_____\/\\\_
  --              _\/\\\_____\//\\\____/\\\/////\\\___\/\\\_____________\/\\\_________\//\\\\\___________\/\\\______\/\\\_____________\/\\\_
  --               _\/\\\______\//\\\__\//\\\\\\\\/\\__\/\\\___________/\\\\\\\\\_______\//\\\_________/\\\\\\\\\\\__\/\\\_____________\/\\\_
  --                _\///________\///____\////////\//___\///___________\/////////_________\///_________\///////////___\///______________\///__
  --       ]]
  --     dashboard.section.header.val = vim.split(logo1, "\n")
  --
  --     local button = dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>")
  --     button.opts.hl = "AlphaButtons"
  --     button.opts.hl_shortcut = "AlphaShortcut"
  --     table.insert(dashboard.section.buttons.val, 4, button)
  --     return dashboard
  --   end,
  -- },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        -- animation = require("mini.indentscope").gen_animation.exponential({ duration = 10 }),
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
}
