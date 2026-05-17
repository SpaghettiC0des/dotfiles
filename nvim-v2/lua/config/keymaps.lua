-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })

-- smart-splits keymaps
local smart_splits_ok, smart_splits = pcall(require, "smart-splits")
if smart_splits_ok then
  vim.keymap.set("n", "<A-h>", smart_splits.resize_left, { desc = "Resize left" })
  vim.keymap.set("n", "<A-j>", smart_splits.resize_down, { desc = "Resize down" })
  vim.keymap.set("n", "<A-k>", smart_splits.resize_up, { desc = "Resize up" })
  vim.keymap.set("n", "<A-l>", smart_splits.resize_right, { desc = "Resize right" })
  
  vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move cursor left" })
  vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move cursor down" })
  vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move cursor up" })
  vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move cursor right" })
  vim.keymap.set("n", "<C-\\>", smart_splits.move_cursor_previous, { desc = "Move cursor to previous" })
end
