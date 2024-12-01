-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local esc_save = "<esc>"
map("i", "jk", esc_save, { noremap = true, silent = true })
map("i", "kj", esc_save, { noremap = true, silent = true })

-- Remove default move Lines
vim.keymap.del({ "n", "v", "i" }, "<M-j>")
vim.keymap.del({ "n", "v", "i" }, "<M-k>")
-- Remove this terminal mapping, because we are now using wezterm as a bottom pane terminal
vim.keymap.del("n", "<C-/>")
-- Move lines
map("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-J>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-K>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
--
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- map(
--   "n",
--   "<leader>cp",
--   "<cmd>lua require('package-info').show({ force = true })<cr>",
--   { desc = "+Package Info", silent = true, noremap = true }
-- )

-- map(
--   "n",
--   "<leader>gB",
--   "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>",
--   { desc = "Toggle current line blame", silent = true, noremap = true }
-- )
local set_keymap = vim.api.nvim_set_keymap
-- package-info keymaps
set_keymap(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle({ force = true})<cr>",
  { silent = true, noremap = true, desc = "Toggle" }
)
set_keymap(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
set_keymap(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
set_keymap(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
set_keymap(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)

-- smart-splits keymaps
map("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize left" })
map("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize down" })
map("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize up" })
map("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize right" })
-- moving between splits
map("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move cursor left" })
map("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move cursor down" })
map("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move cursor up" })
map("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move cursor right" })
map("n", "<C-\\>", require("smart-splits").move_cursor_previous, { desc = "Move cursor to previous" })
-- swapping buffers between windows
-- map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
-- map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
-- map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
-- map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
