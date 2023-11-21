-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jk to escape
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", "∆", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "˚", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "˚", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "∆", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "˚", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- vim.keymap.set("n", "<leader>ft", function()
--   local count = vim.v.count1
--   require("toggleterm").toggle(count, 0, Util.root.get(), "float")
-- end, { desc = "Terminal (root dir)" })

vim.keymap.set("n", "<c-/>", function()
  require("toggleterm").toggle_all()
end, { desc = "Toggle all terminal" })

-- vim.keymap.set("n", "<leader>fh", function()
--   local count = vim.v.count1
--   require("toggleterm").toggle(count, 0, Util.root.get(), "horizontal")
-- end, { desc = "Toggle all terminal" })
