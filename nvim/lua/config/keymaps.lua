-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<CR>", ":nohlsearch<CR>", { noremap = true, silent = true })
-- vim.keymap.set("", "<Leader>x", ":DeleteWS<CR>", { noremap = true })
