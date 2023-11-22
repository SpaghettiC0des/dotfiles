local Util = require("lazyvim.util")
return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      -- symbols outline
      local edgy_idx = Util.plugin.extra_idx("ui.edgy")
      local aerial_idx = Util.plugin.extra_idx("editor.aerial")

      if edgy_idx and edgy_idx > aerial_idx then
        Util.warn("The `edgy.nvim` extra must be **imported** before the `aerial.nvim` extra to work properly.", {
          title = "LazyVim",
        })
      end

      opts.left = {}
      opts.right = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = function()
            vim.api.nvim_input("<esc><space>e")
          end,
          size = { height = 0.5 },
        },
        { title = "Neotest Summary", ft = "neotest-summary" },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        {
          title = "Aerial",
          ft = "aerial",
          pinned = true,
          open = "AerialOpen",
        },
        "neo-tree",
      }
      opts.animate = {
        enabled = false,
      }
    end,
  },
}
