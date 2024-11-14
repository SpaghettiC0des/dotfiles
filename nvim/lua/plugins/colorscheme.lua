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
        -- Existing Telescope configurations
        local prompt = "#090810"
        local results = "#090810"
        local preview = "#090810"
        local border_col = "#2d3149"

        -- Telescope configs (keeping your existing setup)
        hl.TelescopeNormal = { bg = results, fg = c.fg }
        hl.TelescopeBorder = { bg = results, fg = border_col }
        hl.TelescopePromptNormal = { bg = prompt, fg = "#c0caf5" }
        hl.TelescopePromptBorder = { bg = prompt, fg = "#7aa2f7" }
        hl.TelescopePromptTitle = { bg = "#7aa2f7", fg = "#090810", bold = true }
        hl.TelescopePreviewTitle = { bg = "#bb9af7", fg = "#090810", bold = true }
        hl.TelescopePreviewBorder = { bg = preview, fg = border_col }
        hl.TelescopeResultsTitle = { bg = "#9ece6a", fg = "#090810", bold = true }
        hl.TelescopeResultsBorder = { bg = results, fg = border_col }
        hl.TelescopeSelection = { bg = "#2d3149", fg = "#c0caf5" }

        -- LazyGit customizations
        hl.LazyGitNormal = { bg = "#090810", fg = "#c0caf5" }
        hl.LazyGitBorder = { fg = border_col }
        hl.LazyGitBranch = { fg = "#7aa2f7", bold = true }
        hl.LazyGitFileName = { fg = "#bb9af7" }
        hl.LazyGitCommitHash = { fg = "#9ece6a" }
        hl.LazyGitCommitMessage = { fg = "#c0caf5" }
        hl.LazyGitStatusAdded = { fg = "#9ece6a" }
        hl.LazyGitStatusModified = { fg = "#7aa2f7" }
        hl.LazyGitStatusDeleted = { fg = "#f7768e" }
        hl.LazyGitStatusUntracked = { fg = "#bb9af7" }
        hl.LazyGitInactiveBorder = { fg = "#2d3149" }
        hl.LazyGitHeader = { bg = "#2d3149", fg = "#c0caf5", bold = true }
      end,
      on_colors = function(colors)
        colors.bg = "#090810"
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
