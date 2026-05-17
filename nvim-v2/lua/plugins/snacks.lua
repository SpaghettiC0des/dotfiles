return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    image = { enabled = true },
    animate = { enabled = false },
    bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true, animate = { enabled = false } },
    -- input = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
        },
      },
    },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
}
