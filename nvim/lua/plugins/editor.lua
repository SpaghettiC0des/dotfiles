return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    keys = {
      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize left" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize down" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize up" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize right" },
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move cursor left" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move cursor down" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move cursor up" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move cursor right" },
    },
    config = function()
      require("smart-splits").setup({
        ignored_filetypes = {},
      })
    end,
  },
  {
    "tadaa/vimade",
    opts = {
      recipe = { "minimalist", { animate = false } },
      ncmode = "buffers",
      fadelevel = 0.5,
      tint = {
        bg = { rgb = { 0, 0, 0 }, intensity = 0.4 },
      },
      basebg = "",
      blocklist = {
        default = {
          buf_opts = { buftype = { "prompt", "terminal", "neo-tree" } },
          win_config = { relative = true },
        },
      },
      link = {},
      groupdiff = true,
      groupscrollbind = false,
      enablefocusfading = false,
      enablebasegroups = true,
      checkinterval = 100,
      usecursorhold = false,
      detecttermcolors = false,
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
}