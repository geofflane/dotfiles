-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Backup
opt.backup = false -- Don't make a backup before overwriting a file.
opt.writebackup = false -- And again.

local prefix = vim.fn.expand("~/.vim")
-- in // means the file name will be built from the full path to avoid conflicts
-- Keep swap files in one location,
-- Keep backup files in one location, if they are enabled
opt.undodir = { prefix .. "/tmp//,." }
opt.backupdir = { prefix .. "/tmp//,." }
opt.directory = { prefix .. "/tmp//,." }

-- Searching
opt.ignorecase = true -- Case-insensitive searching.
opt.smartcase = true -- But case-sensitive if expression contains a capital letter.
opt.incsearch = true -- Highlight matches as you type.
opt.hlsearch = true -- Highlight matches.
--
-- Whitespace
opt.list = true -- Show invisibles, display tabs as '▸   ', trailing spaces as '•'
opt.listchars = "tab:▸ ,trail:•" -- Show some whitespace that should never be used
opt.tabstop = 8 -- The one true tab width. (According to Kernighan and Pike)
opt.shiftwidth = 2 -- But doesn't mean I want everything indented to tabstop.
opt.expandtab = true -- Use spaces instead of tabs because we're not a monster
opt.ttyfast = true -- smoother output, we're not on a 1200 dialup :)
opt.mouse = "a" -- It's 2015 (or later) we have mice
--
-- ignore on completions, used by command-t at least, likely others
opt.wildignore = ""
vim.tbl_extend("force", vim.opt.wildignore or {}, { ".git", "vendor/bundle/**", "log/**", "tmp/**" })

-- Themes
opt.background = "dark" -- Background.

opt.conceallevel = 0 -- don't hide my json strings
