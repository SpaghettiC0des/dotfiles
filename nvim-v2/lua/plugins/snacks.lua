local function focus_main_window(picker)
  local root = picker.layout and picker.layout.root
  if not (root and root.win and vim.api.nvim_win_is_valid(root.win)) then
    return
  end

  -- Explorer windows are floating children of the sidebar's layout root.
  -- Entering that root lets Snacks redirect focus to the adjacent main window.
  vim.api.nvim_set_current_win(root.win)
end

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = { enabled = true },
    animate = { enabled = false },
    indent = { animate = { enabled = false } },
    picker = {
      actions = {
        explorer_focus_main = focus_main_window,
      },
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          win = {
            input = {
              keys = {
                ["<C-h>"] = { "explorer_focus_main", mode = "n" },
              },
            },
            list = {
              keys = {
                ["<C-h>"] = "explorer_focus_main",
              },
            },
          },
        },
      },
    },
    notifier = {
      style = "compact",
      -- Filter out empty/unhelpful LSP messages
      filter = function(notif)
        if notif.message then
          local msg = notif.message
          -- Suppress empty hover results from language servers
          if msg:find("No information available") or msg:find("^%s*$") then
            return false
          end
        end
        return true
      end,
    },
    scroll = { enabled = false },
  },
}
