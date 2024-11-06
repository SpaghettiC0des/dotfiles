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
      -- on_highlights = function(hl, c)
      --   local prompt = "#29202b"
      --   hl.TelescopeNormal = {
      --     bg = c.bg_dark,
      --     fg = c.fg_dark,
      --   }
      --   hl.TelescopeBorder = {
      --     bg = c.bg_dark,
      --     fg = c.bg_dark,
      --   }
      --   hl.TelescopePromptNormal = {
      --     bg = prompt,
      --   }
      --   hl.TelescopePromptBorder = {
      --     bg = prompt,
      --     fg = prompt,
      --   }
      --   hl.TelescopePromptTitle = {
      --     bg = prompt,
      --     fg = c.fg_dark,
      --   }
      --   hl.TelescopePreviewTitle = {
      --     bg = c.bg_dark,
      --     fg = c.fg_dark,
      --   }
      --   hl.TelescopeResultsTitle = {
      --     bg = c.bg_dark,
      --     fg = c.fg_dark,
      --   }
      -- end,
      on_colors = function(colors)
        colors.bg = "#070010"
        colors.bg_dark = "#070010"
        -- colors.bg = "#000000"
        -- colors.bg_dark = "#0d0414"
        -- colors.bg = "#0d0414"
        -- colors.bg = "#150421"
        -- colors.hint = "#6b32a3"
        -- colors.hint = colors.orange
        -- colors.hint = "#00ff00"
        colors.error = "#ff0000"
        colors.NeoTreeNormal = {
          bg = "#0d0414",
          fg = "#ff0000",
        }
        colors.NeoTreeNormalNC = {
          bg = "#0d0414",
          fg = "#ff0000",
        }
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
