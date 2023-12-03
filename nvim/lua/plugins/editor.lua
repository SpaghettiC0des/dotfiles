return {
  { "folke/flash.nvim", enabled = false },
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    event = "BufReadPre",
    keys = {
      {
        ";;",
        function()
          require("hop").hint_patterns()
        end,
        desc = "Hint patterns",
      },
      {
        ";d",
        function()
          require("hop").hint_words({ multi_windows = true })
        end,
        desc = "Hint words (multi windows)",
      },
      {
        ";w",
        function()
          require("hop").hint_words()
        end,
        desc = "Hint words",
      },
      {
        ";k",
        function()
          require("hop").hint_vertical()
        end,
        desc = "Hint vertical",
      },
      {
        ";j",
        function()
          require("hop").hint_lines_skip_whitespace()
        end,
        desc = "Hint line start",
      },
      {
        "f",
        function()
          local directions = require("hop.hint").HintDirection
          require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end,
      },
      {
        "F",
        function()
          local directions = require("hop.hint").HintDirection
          require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end,
      },
      {
        "t",
        function()
          local directions = require("hop.hint").HintDirection
          require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end,
      },
      {
        "T",
        function()
          local directions = require("hop.hint").HintDirection
          require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end,
      },
    },
    config = function()
      require("hop").setup()
    end,
  },
  {
    "lbrayner/vim-rzip",
  },
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup()
    end,
    keys = {
      {
        "<leader>Pi",
        function()
          require("package-info").show()
        end,
        desc = "Show package info",
      },
    },
  },
}
