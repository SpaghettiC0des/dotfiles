return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      on_colors = function(colors)
        colors.bg = "#0a0a0f"
        colors.bg_dark = "#050508"
        colors.bg_float = "#0a0a0f"
        colors.bg_popup = "#0a0a0f"
        colors.bg_sidebar = "#0a0a0f"
        colors.bg_statusline = "#0a0a0f"
      end,
    },
  },
}
