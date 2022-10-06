local Plug = require 'usermod.vimplug'

Plug.begin('~/.config/nvim/plugged')

-- Plug 'scrooloose/nerdtree' -- Why can't I quit you?
Plug 'kyazdani42/nvim-web-devicons' -- optional, for file icons
Plug('kyazdani42/nvim-tree.lua', {
  config = function()
    local nvimTree = require("nvim-tree")
    nvimTree.setup()
    vim.api.nvim_set_keymap('', '<Leader><Leader>', ':NvimTreeToggle<CR>', {noremap = true})
  end
})

Plug('mileszs/ack.vim', {     -- Better file searching
  run = function()
    vim.g.ackprg = 'ag --vimgrep --smart-case'
    vim.cmd('cnoreabbrev Ag Ack')
    vim.cmd('cnoreabbrev ag Ack')
    -- Use ag over grep
    vim.opts.grepprg = 'ag --nogroup --nocolor'
  end
})
-- TODO: Look into fzf or nvim specific one
Plug('ctrlpvim/ctrlp.vim', {
  run = function()
    vim.g.ctrlp_user_command = 'ag %s -l --nocolor -g ""' -- Use ag in CtrlP for listing files. Fast and respects .gitignore
    vim.g.ctrlp_use_caching = 0                           -- ag is fast enough that CtrlP doesn't need to cache
    vim.g.ctrlp_by_filename = 1      -- search by filename by default, that's normally what I want
  end
})

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'



Plug('vim-scripts/tComment')  -- Commenting
Plug('triglav/vim-visual-increment') -- visual increment Ctrl+A

if(vim.fn.has("mac"))
then
  Plug('zerowidth/vim-copy-as-rtf') -- Copy syntax highlighted code into rtg
end
Plug('Shougo/neosnippet.vim')
Plug('Shougo/neosnippet-snippets')

Plug('tpope/vim-endwise')           --" Put ends after things
Plug('jacquesbh/vim-showmarks')      -- Visually show marks in buffer

-- ==== Completion ====
-- Plug('Shougo/deoplete.nvim')
Plug('neoclide/coc.nvim', {merged = false, rev = 'release'})
if(not vim.fn.has('nvim'))
then
  Plug('roxma/nvim-yarp')
  Plug('roxma/vim-hug-neovim-rpc')
end


-- ========== Themes and visual ============
-- Themes
Plug('veloce/vim-aldmeris', {
  config = function()
    vim.cmd('colorscheme aldmeris')
  end
})
-- Plug('vim-scripts/Zenburn')
-- Plug('altercation/vim-colors-solarized')
-- Plug('morhetz/gruvbox')
-- Plug('chuling/vim-equinusocio-material')
-- Plug('vim-airline/vim-airline') -- Handy plugin for a nice statusline
-- Plug('vim-airline/vim-airline-themes')


-- ========== Langauge stuff ==============
Plug('sheerun/vim-polyglot')    -- Polyglot: A collection of language packs, loaded on demand

Plug('vim-scripts/taglist.vim')
Plug('vim-scripts/SyntaxRange') -- Supports multiple syntaxes in the same file
Plug('dense-analysis/ale')      -- On-the-fly syntax checking

-- Markdown
-- Plug('tpope/vim-markdown.git')

-- Elixir
Plug('mhinz/vim-mix-format')
Plug('avdgaag/vim-phoenix')

-- Ruby and Rails
-- Plug('tpope/vim-rbenv')
-- Plug('tpope/vim-bundler')
-- Plug('tpope/vim-rails')
-- Plug('thoughtbot/vim-rspec')

-- Clojure
-- Plug('tpope/vim-fireplace')
-- Plug('tpope/vim-classpath')
-- Plug('vim-scripts/paredit.vim') -- paredit, better paren handling for the lisps
-- Plug('vim-scripts/vim-niji')    -- rainbow

-- Haskell
-- Plug('eagletmt/ghcmod-vim')

Plug.ends()
