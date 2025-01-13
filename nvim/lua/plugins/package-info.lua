return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("package-info").setup({
      icons = {
        enable = true,
      },
      autostart = true,
      hide_up_to_date = false,
    })
  end,
}
