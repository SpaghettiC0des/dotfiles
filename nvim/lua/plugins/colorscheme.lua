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
        local prompt = "#090810" -- Darker background for prompt
        local results = "#090810" -- Matching background for consistency
        local preview = "#090810" -- Matching background for consistency
        local border_col = "#2d3149" -- Subtle but visible border

        -- Normal text and borders
        hl.TelescopeNormal = {
          bg = results,
          fg = c.fg,
        }

        -- Main border
        hl.TelescopeBorder = {
          bg = results,
          fg = border_col,
        }

        -- Prompt section
        hl.TelescopePromptNormal = {
          bg = prompt,
          fg = "#c0caf5", -- Brighter text for better visibility
        }

        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = "#7aa2f7", -- Highlighted border for prompt
        }

        hl.TelescopePromptTitle = {
          bg = "#7aa2f7",
          fg = "#090810",
          bold = true,
        }

        -- Preview section
        hl.TelescopePreviewTitle = {
          bg = "#bb9af7",
          fg = "#090810",
          bold = true,
        }

        hl.TelescopePreviewBorder = {
          bg = preview,
          fg = border_col,
        }

        -- Results section
        hl.TelescopeResultsTitle = {
          bg = "#9ece6a",
          fg = "#090810",
          bold = true,
        }

        hl.TelescopeResultsBorder = {
          bg = results,
          fg = border_col,
        }

        -- Selection highlighting
        hl.TelescopeSelection = {
          bg = "#2d3149",
          fg = "#c0caf5",
        }
      end,
      on_colors = function(colors)
        colors.bg = "#090810" -- Very dark purple-black
        colors.bg_dark = "#06050c" -- Almost pure black with slight purple
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
