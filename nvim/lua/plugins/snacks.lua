return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      scroll = { enabled = false, animate = { duration = { step = 15, total = 50 } } },
      dashboard = {
        preset = {
          header = [[
  ██╗  ██╗ █████╗ ██████╗ ██╗         ██╗   ██╗██╗███╗   ███╗
  ██║ ██╔╝██╔══██╗██╔══██╗██║         ██║   ██║██║████╗ ████║
  █████╔╝ ███████║██████╔╝██║         ██║   ██║██║██╔████╔██║
  ██╔═██╗ ██╔══██║██╔══██╗██║         ╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║  ██╗██║  ██║██║  ██║███████╗     ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
        },
        sections = {
          -- { section = "header" },
          {
            -- pane = 2,
            section = "terminal",
            cmd = "chafa ~/.dotfiles/nvim/pusheen.png --format symbols --symbols vhalf --size 60x25  --stretch; sleep .1",
            height = 25,
            -- padding = 2,
          },
          { section = "keys", gap = 1, padding = 1 },
          -- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          -- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          -- {
          --   pane = 2,
          --   icon = " ",
          --   title = "Git Status",
          --   section = "terminal",
          --   enabled = vim.fn.isdirectory(".git") == 1,
          --   cmd = "hub status --short --branch --renames",
          --   height = 5,
          --   padding = 1,
          --   ttl = 5 * 60,
          --   indent = 3,
          -- },
          { section = "startup" },
        },
      },
    },
  },
}
