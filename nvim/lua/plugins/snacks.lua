return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = [[
  ██╗   ██╗███████╗     ██████╗ ██████╗ ██████╗ ███████╗
  ██║   ██║██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝
  ██║   ██║███████╗    ██║     ██║   ██║██║  ██║█████╗
  ╚██╗ ██╔╝╚════██║    ██║     ██║   ██║██║  ██║██╔══╝
   ╚████╔╝ ███████║    ╚██████╗╚██████╔╝██████╔╝███████╗
    ╚═══╝  ╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
        ]],
        },
        sections = {
          { section = "header", pane = 2 },
          {
            section = "terminal",
            cmd = "chafa ~/.config/nvim/dashboard.jpg --colors full --dither ordered --dither-intensity 1.0 --format symbols --symbols all --size 60x27 --stretch; sleep .1",
            height = 27,
            padding = 1,
          },
          {
            pane = 2,
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
          },
        },
      },
    },
  },
}
