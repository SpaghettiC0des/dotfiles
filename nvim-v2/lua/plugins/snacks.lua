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
    notifier = {
      enabled = true,
      style = "compact",
      -- Filter out empty/unhelpful LSP messages
      filter = function(notif)
        if notif.message then
          local msg = notif.message
          -- Suppress "No information available" from tsgo and other LSPs
          if msg:find("No information available") or msg:find("^%s*$") then
            return false
          end
        end
        return true
      end,
    },
    -- quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
}
