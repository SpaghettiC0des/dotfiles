-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("i", "jk", "<esc>", { noremap = true, silent = true })

-- Move Lines
map("n", "∆", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "˚", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "˚", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "∆", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "˚", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "∆", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

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
