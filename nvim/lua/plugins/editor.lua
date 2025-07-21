return {
  {
    "ibhagwan/fzf-lua",
    enabled = false,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    keys = {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize left",
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize down",
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize up",
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize right",
      },
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move cursor left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move cursor down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move cursor up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move cursor right",
      },
    },
    config = function()
      require("smart-splits").setup({
        ignored_filetypes = {},
        ignored_buftypes = { "nofile", "prompt", "popup", "terminal" },
        -- Stop at edge instead of wrapping to avoid getting stuck
        at_edge = "stop",
        -- Handle floating windows by moving to previous window
        float_win_behavior = "previous",
        -- Allow cursor movement between different row levels
        move_cursor_same_row = false,
        -- Resize mode
        resize_mode = {
          quit_key = "<ESC>",
          resize_keys = { "h", "j", "k", "l" },
          silent = true,
        },
      })
    end,
  },
  {
    "tadaa/vimade",
    event = "VeryLazy",
    config = function()
      require("vimade").setup({
        recipe = { "minimalist", { animate = true } },
        ncmode = "windows", -- Change to windows mode for better explorer support
        fadelevel = 0.5,
        tint = {
          bg = { rgb = { 0, 0, 0 }, intensity = 1 },
        },
        blocklist = {
          default = {
            buf_opts = { buftype = { "prompt", "terminal" } },
            win_config = { relative = true },
          },
        },
        -- Explicitly allow nofile buffers (snacks explorer uses nofile)
        allowlist = {
          default = {
            buf_opts = { buftype = { "nofile" } },
            filetype = { "snacks_picker_list" },
          },
        },
        -- Force enable for nofile buffers (which includes snacks explorer)
        enablefocusfading = true,
        enablebasegroups = true,
      })
    end,
  },
}
