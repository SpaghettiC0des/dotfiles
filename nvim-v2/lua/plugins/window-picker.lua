return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  keys = {
    {
      "<leader>ww",
      function()
        local win = require("window-picker").pick_window()
        if win and vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_set_current_win(win)
        end
      end,
      desc = "Pick Window",
    },
  },
  opts = {
    hint = "floating-big-letter",
    selection_chars = "FJDKSLA;CMRUEIWOQP",
    show_prompt = false,
    filter_rules = {
      autoselect_one = true,
      include_current_win = false,
      include_unfocusable_windows = false,
      bo = {
        filetype = {
          "NvimTree",
          "neo-tree",
          "notify",
          "snacks_notif",
          "noice",
        },
        buftype = {
          "prompt",
          "quickfix",
        },
      },
    },
  },
}
