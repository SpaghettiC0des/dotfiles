return {
  -- {
  --   "projekt0n/github-nvim-theme",
  --   vscode = false,
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  -- },
  {
    "catppuccin/nvim",
    vscode = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- no_italic = true,
        color_overrides = {
          mocha = {
            base = "#0f0c17",
            -- base = "#120121",
            -- base = "#0e001a",
            -- base = "#041626",
            -- base = "#18192f",
            mantle = "#000000",
            crust = "#000000",
          },
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    vscode = false,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "night-owl",
      colorscheme = "tokyonight-night",
      -- colorscheme = "catppuccin",
    },
  },
}
