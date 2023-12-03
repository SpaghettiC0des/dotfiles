-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local del = vim.keymap.del
-- jk to escape
set("i", "jk", "<ESC>", { noremap = true, silent = true })

-- Move Lines
set("n", "∆", "<cmd>m .+1<cr>==", { desc = "Move down" })
set("n", "˚", "<cmd>m .-2<cr>==", { desc = "Move up" })
set("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
set("i", "˚", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
set("v", "∆", ":m '>+1<cr>gv=gv", { desc = "Move down" })
set("v", "˚", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- set("n", "<leader>ft", function()
--   local count = vim.v.count1
--   require("toggleterm").toggle(count, 0, Util.root.get(), "float")
-- end, { desc = "Terminal (root dir)" })

-- set("n", "<leader>fh", function()
--   local count = vim.v.count1
--   require("toggleterm").toggle(count, 0, Util.root.get(), "horizontal")
-- end, { desc = "Toggle all terminal" })
--

-- Resize window using <ctrl> arrow keys
del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")
set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
set("t", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
set("t", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
set("t", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
set("t", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Terminal
-- local ttermUi = require("toggleterm.ui")
set("n", "<c-/>", "<cmd>ToggleTerm<cr>", { desc = "Toggle all terminal" })
set("t", "<c-/>", "<cmd>ToggleTermToggleAll<cr>")

-- clear terminal
set("t", "<c-l>", "<cmd>TermExec go_back=0 cmd='clear'<cr>", { desc = "Clear terminal" })
