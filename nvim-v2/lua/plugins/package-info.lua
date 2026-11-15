return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    {
      "<leader>cP",
      function()
        require("package-info").show({ force = true })
      end,
      desc = "Check package versions",
    },
  },
  opts = {
    autostart = false,
    hide_up_to_date = false,
    hide_unstable_versions = false,
    colors = {
      up_to_date = "#3C4048",
      outdated = "#d19a66",
      invalid = "#ee4b2b",
    },
    icons = {
      enable = true,
      style = { up_to_date = "✅ ", outdated = "⚠️", invalid = "❌ " },
    },
  },
}
