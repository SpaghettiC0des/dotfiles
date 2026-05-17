return {
  "TaDaa/vimade",
  config = function()
    require("vimade").setup({
      fadelevel = 0.4,
      enablesigns = 1,
    })
  end,
}