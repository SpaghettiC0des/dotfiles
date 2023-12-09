return {
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
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump({}) end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      { "gl", mode = { "n"}, function ()
        require("flash").jump({
          search = { mode = "search", max_length = 0 },
          label = { after = { 0, 0 } },
          pattern = [[\s]]
        })
      end, desc = "Jump line" },
      { "gW", mode = {"n"}, function ()
        require("flash").jump({
          pattern = ".", -- initialize pattern with any char
          search = {
            mode = function(pattern)
              -- remove leading dot
              if pattern:sub(1, 1) == "." then
                pattern = pattern:sub(2)
              end
              -- return word pattern and proper skip pattern
              return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
            end,
          },
          -- select the range
          jump = { pos = "range" },
        })
      end, desc = "Jump any word" },
      { "gw", mode = {"n"}, function ()
        local Flash = require("flash")

        local function format(opts)
          -- always show first and second label
          return {
            { opts.match.label1, "FlashMatch" },
            { opts.match.label2, "FlashLabel" },
          }
        end

        Flash.jump({
          search = { mode = "search" },
          label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
          pattern = [[\<]],
          action = function(match, state)
            state:hide()
            Flash.jump({
              search = { max_length = 0 },
              highlight = { matches = false },
              label = { format = format },
              matcher = function(win)
                -- limit matches to the current label
                return vim.tbl_filter(function(m)
                  return m.label == match.label and m.win == win
                end, state.results)
              end,
              labeler = function(matches)
                for _, m in ipairs(matches) do
                  m.label = m.label2 -- use the second label
                end
              end,
            })
          end,
          labeler = function(matches, state)
            local labels = state:labels()
            for m, match in ipairs(matches) do
              match.label1 = labels[math.floor((m - 1) / #labels) + 1]
              match.label2 = labels[(m - 1) % #labels + 1]
              match.label = match.label1
            end
          end,
        })
      end,
      desc = "Jump word"
      }
    },
  },
  -- {
  --   "phaazon/hop.nvim",
  --   branch = "v2",
  --   event = "BufReadPre",
  --   keys = {
  --     {
  --       ";;",
  --       function()
  --         require("hop").hint_patterns()
  --       end,
  --       desc = "Hint patterns",
  --     },
  --     {
  --       ";d",
  --       function()
  --         require("hop").hint_words({ multi_windows = true })
  --       end,
  --       desc = "Hint words (multi windows)",
  --     },
  --     {
  --       ";w",
  --       function()
  --         require("hop").hint_words()
  --       end,
  --       desc = "Hint words",
  --     },
  --     {
  --       ";k",
  --       function()
  --         require("hop").hint_vertical()
  --       end,
  --       desc = "Hint vertical",
  --     },
  --     {
  --       ";j",
  --       function()
  --         require("hop").hint_lines_skip_whitespace()
  --       end,
  --       desc = "Hint line start",
  --     },
  --     {
  --       "f",
  --       function()
  --         local directions = require("hop.hint").HintDirection
  --         require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  --       end,
  --     },
  --     {
  --       "F",
  --       function()
  --         local directions = require("hop.hint").HintDirection
  --         require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  --       end,
  --     },
  --     {
  --       "t",
  --       function()
  --         local directions = require("hop.hint").HintDirection
  --         require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  --       end,
  --     },
  --     {
  --       "T",
  --       function()
  --         local directions = require("hop.hint").HintDirection
  --         require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  --       end,
  --     },
  --   },
  --   config = function()
  --     require("hop").setup()
  --   end,
  -- },
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
