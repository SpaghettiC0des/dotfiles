-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymapSet = vim.keymap.set
local keymapDel = vim.keymap.del
local esc_save = "<esc>"
keymapSet("i", "jk", esc_save, { noremap = true, silent = true })
keymapSet("i", "kj", esc_save, { noremap = true, silent = true })

-- Remove default move Lines
keymapDel({ "n", "v", "i" }, "<M-j>")
keymapDel({ "n", "v", "i" }, "<M-k>")
-- Remove this terminal mapping, because we are now using wezterm as a bottom pane terminal
keymapDel("n", "<C-/>")
-- Move lines, the default is <A-j> (lowercased),
-- we are already using this for window resize, so we will change it to <A-J> (uppercase)
keymapSet("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
keymapSet("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
keymapSet("i", "<A-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
keymapSet("i", "<A-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
keymapSet("v", "<A-J>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
keymapSet("v", "<A-K>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
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
-- package-info keymaps
keymapSet(
  "n",
  "<leader>sA",
  "<cmd>lua require('grug-far').open({ engine = 'astgrep'})<cr>",
  { silent = true, noremap = true, desc = "Search and Replace (AST-Grep)" }
)
keymapSet(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle({ force = true})<cr>",
  { silent = true, noremap = true, desc = "Toggle" }
)
keymapSet(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
keymapSet(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
keymapSet(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
keymapSet(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)

-- smart-splits keymaps (wrapped in pcall to avoid errors if not loaded)
local smart_splits_ok, smart_splits = pcall(require, "smart-splits")
if smart_splits_ok then
  keymapSet("n", "<A-h>", smart_splits.resize_left, { desc = "Resize left" })
  keymapSet("n", "<A-j>", smart_splits.resize_down, { desc = "Resize down" })
  keymapSet("n", "<A-k>", smart_splits.resize_up, { desc = "Resize up" })
  keymapSet("n", "<A-l>", smart_splits.resize_right, { desc = "Resize right" })
  
  -- moving between splits
  keymapSet("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move cursor left" })
  keymapSet("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move cursor down" })
  keymapSet("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move cursor up" })
  keymapSet("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move cursor right" })
  keymapSet("n", "<C-\\>", smart_splits.move_cursor_previous, { desc = "Move cursor to previous" })
end
-- swapping buffers between windows
-- map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
-- map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
-- map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
-- map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
