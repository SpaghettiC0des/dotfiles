return {
  -- {
  --   "oxfist/night-owl.nvim",
  -- },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local palletes = {
  --       all = { red = "#ff0000" },
  --       github_dark_default = {
  --         -- Defining multiple shades is done by passing a table
  --         red = {
  --           base = "#8e1519",
  --           bright = "#ee0000",
  --         },
  --       },
  --     }
  --     require("github-theme").setup({
  --       palletes = palletes,
  --     })
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        -- Color palette
        local colors = {
          deep_dark = "#090810",
          -- deep_dark = "#000000",
          darker = "#06050c",
          border = "#2d3149",
          text = {
            primary = "#c0caf5",
            dark = "#090810",
          },
          accent = {
            blue = "#7aa2f7",
            purple = "#bb9af7",
            green = "#9ece6a",
            red = "#f7768e",
          },
        }

        -- Telescope configs
        hl.TelescopeNormal = { bg = colors.deep_dark, fg = c.fg }
        hl.TelescopeBorder = { bg = colors.deep_dark, fg = colors.border }
        hl.TelescopePromptNormal = { bg = colors.deep_dark, fg = colors.text.primary }
        hl.TelescopePromptBorder = { bg = colors.deep_dark, fg = colors.accent.blue }
        hl.TelescopePromptTitle = { bg = colors.accent.blue, fg = colors.text.dark, bold = true }
        hl.TelescopePreviewTitle = { bg = colors.accent.purple, fg = colors.text.dark, bold = true }
        hl.TelescopePreviewBorder = { bg = colors.deep_dark, fg = colors.border }
        hl.TelescopeResultsTitle = { bg = colors.accent.green, fg = colors.text.dark, bold = true }
        hl.TelescopeResultsBorder = { bg = colors.deep_dark, fg = colors.border }
        hl.TelescopeSelection = { bg = colors.border, fg = colors.text.primary }

        -- LazyGit customizations
        hl.LazyGitNormal = { bg = colors.deep_dark, fg = colors.text.primary }
        hl.LazyGitBorder = { fg = colors.border }
        hl.LazyGitBranch = { fg = colors.accent.blue, bold = true }
        hl.LazyGitFileName = { fg = colors.accent.purple }
        hl.LazyGitCommitHash = { fg = colors.accent.green }
        hl.LazyGitCommitMessage = { fg = colors.text.primary }
        hl.LazyGitStatusAdded = { fg = colors.accent.green }
        hl.LazyGitStatusModified = { fg = colors.accent.blue }
        hl.LazyGitStatusDeleted = { fg = colors.accent.red }
        hl.LazyGitStatusUntracked = { fg = colors.accent.purple }
        hl.LazyGitInactiveBorder = { fg = colors.border }
        hl.LazyGitHeader = { bg = colors.border, fg = colors.text.primary, bold = true }
      end,
      on_colors = function(colors)
        -- colors.bg = "#090810"
        colors.bg = "#000000"
        colors.bg_dark = "#06050c"
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "night-owl",
      colorscheme = "tokyonight-night",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "github_dark_default",
    },
  },
}
