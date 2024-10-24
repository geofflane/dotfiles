-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<CR>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear highlights" })
-- vim.keymap.set("", "<Leader>vd", ":DeleteWS<CR>", { noremap = true, desc = "Delete trailing whitespace" })
