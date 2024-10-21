if true then
  return {}
end
return {
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local trouble = require("trouble")
  --     if not trouble.statusline then
  --       LazyVim.error("You have enabled the **trouble-v3** extra,\nbut still need to update it with `:Lazy`")
  --       return
  --     end
  --
  --     local symbols = trouble.statusline({
  --       mode = "symbols",
  --       groups = {},
  --       title = false,
  --       filter = { range = true },
  --       format = "{kind_icon}{symbol.name:Normal}",
  --     })
  --     table.insert(opts.sections.lualine_c, {
  --       symbols.get,
  --       cond = symbols.has,
  --     })
  --   end,
  -- },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          ---@diagnostic disable-next-line: unused-local
          filter = function(_buf, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },
}
