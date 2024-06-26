-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Backup
-- TODO: Figure out how directory and backupdir work in neovim
vim.opt.backup = false -- Don't make a backup before overwriting a file.
vim.opt.writebackup = false -- And again.
vim.cmd("set directory=$HOME/.vim/tmp//,.") -- Keep swap files in one location,  ending
-- in // means the file name will be built
-- from the full path to avoid conflicts
vim.cmd("set backupdir=$HOME/.vim/tmp//,.") -- Keep backup files in one location, if they are enabled

-- Searching
vim.opt.ignorecase = true -- Case-insensitive searching.
vim.opt.smartcase = true -- But case-sensitive if expression contains a capital letter.
vim.opt.incsearch = true -- Highlight matches as you type.
vim.opt.hlsearch = true -- Highlight matches.
--
-- Whitespace
vim.opt.list = true -- Show invisibles, display tabs as '▸   ', trailing spaces as '•'
vim.opt.listchars = "tab:▸ ,trail:•" -- Show some whitespace that should never be used
vim.opt.tabstop = 8 -- The one true tab width. (According to Kernighan and Pike)
vim.opt.shiftwidth = 2 -- But doesn't mean I want everything indented to tabstop.
vim.opt.expandtab = true -- Use spaces instead of tabs because we're not a monster
vim.opt.ttyfast = true -- smoother output, we're not on a 1200 dialup :)
vim.opt.mouse = "a" -- It's 2015 (or later) we have mice
--
-- ignore on completions, used by command-t at least, likely others
vim.opt.wildignore =
  vim.tbl_extend("force", vim.opt.wildignore or {}, { ".git", "vendor/bundle/**", "log/**", "tmp/**" })
vim.opt.foldmethod = "manual" -- I don't always fold code, but when I do, I do it manually

-- Themes
vim.opt.background = "dark" -- Background.

vim.opt.conceallevel = 0 -- don't hide my json strings
