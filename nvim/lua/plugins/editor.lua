return {
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },
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
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    config = function()
      -- require("grug-far").setup({ engine = "astgrep" })
    end,
  },
}
