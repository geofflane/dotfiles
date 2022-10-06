
vim.g.mapleader = '\\'
-- vim.opt.guifont = 'Sauce Code Powerline:h12'
vim.opt.guifont = 'Hack Nerd Font Mono:h12'
vim.opt.encoding = 'utf-8'                       -- Use UTF-8 everywhere.
-- vim.opt.guioptions = vim.opt.guioptions - 'T'     -- Hide toolbar.
-- vim.opt.lines=50 columns=200           -- Window dimensions.

require("plugins")
-- require("mappings")

vim.opt.number = true

vim.opt.shell = '/bin/sh'

-- How to do this in Lua?
vim.cmd('filetype plugin indent on')    -- required

-- Syntax
vim.cmd('syntax enable') -- Turn on syntax highlighting.
-- vim.opt.synmaxcol=200     -- Only highlight 200 cols for performance.

-- View
vim.opt.showcmd = true                       -- Display incomplete commands.
vim.opt.showmode = true                      -- Display the mode you're in.
vim.opt.ruler = true                         -- Show cursor position.
vim.opt.backspace = 'indent,eol,start'       -- Intuitive backspacing.
vim.opt.title = true                         -- Set the terminal's title
vim.opt.visualbell = true                    -- No beeping.
vim.opt.showmatch = true                     -- Show matching brackets

vim.opt.laststatus = 2                       -- Show the status line all the time

vim.opt.number = true                        -- Show line numbers by default.

vim.opt.hidden = true                        -- Handle multiple buffers better.

vim.opt.wildmenu = true                      -- Enhanced command line completion.
vim.opt.wildmode = 'list:longest'            -- Complete files like a shell.

-- Searching
vim.opt.ignorecase = true                    -- Case-insensitive searching.
vim.opt.smartcase = true                     -- But case-sensitive if expression contains a capital letter.
vim.opt.incsearch = true                     -- Highlight matches as you type.
vim.opt.hlsearch = true                      -- Highlight matches.

-- Wrapping
vim.opt.wrap = false                         -- Turn off line wrapping.
vim.opt.scrolloff = 3                        -- Show 3 lines of context around the cursor.
vim.opt.linebreak = true                     -- Be smart about wrapping

-- Backup
vim.opt.backup = false                       -- Don't make a backup before overwriting a file.
vim.opt.writebackup = false                  -- And again.
vim.opt.directory = '$HOME/.vim/tmp//,.'     -- Keep swap files in one location,  ending
                                             -- in // means the file name will be built
                                             -- from the full path to avoid conflicts
vim.opt.backupdir = '$HOME/.vim/tmp//,.'     -- Keep backup files in one location, if they are enabled

-- Whitespace
vim.opt.list = true                          -- Show invisibles, display tabs as '▸   ', trailing spaces as '•'
vim.opt.listchars = 'tab:▸ ,trail:•'         -- Show some whitespace that should never be used
vim.opt.tabstop= 8                           -- The one true tab width. (According to Kernighan and Pike)
vim.opt.shiftwidth= 2                        -- But doesn't mean I want everything indented to tabstop.
vim.opt.expandtab = true                     -- Use spaces instead of tabs because we're not a monster
vim.opt.ttyfast = true                       -- smoother output, we're not on a 1200 dialup :)
vim.opt.mouse = 'a'                          -- It's 2015 (or later) we have mice

if(not vim.fn.has("mac"))
then
  -- Put yanked text in a global clipboard so I can copy between instances like
  -- a normal person. This breaks mac though, so not there
  -- vim.opt.clipboard=unnamedplus
end

-- ignore on completions, used by command-t at least, likely others
vim.opt.wildignore = vim.tbl_extend('force', vim.opt.wildignore or {}, {'.git', 'vendor/bundle/**', 'log/**', 'tmp/**'})
vim.opt.foldmethod = 'manual'             -- I don't always fold code, but when I do, I do it manually

-- Themes
vim.opt.background = 'dark'           -- Background.
