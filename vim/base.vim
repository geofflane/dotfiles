set shell=/bin/sh

filetype plugin indent on    " required

"" Syntax
syntax on                         " Turn on syntax highlighting.
" set synmaxcol=200                 " Only highlight 200 cols for performance.

"" View
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set ruler                         " Show cursor position.
set backspace=indent,eol,start    " Intuitive backspacing.
set title                         " Set the terminal's title
set visualbell                    " No beeping.
set showmatch                     " Show matching brackets

set laststatus=2                  " Show the status line all the time

set number                        " Show line numbers by default.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

"" Searching
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

"" Wrapping
set nowrap                        " Turn off line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set linebreak                     " Be smart about wrapping

"" Backup
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location,  ending
                                  " in // means the file name will be built
                                  " from the full path to avoid conflicts
set backupdir=$HOME/.vim/tmp//,.  " Keep backup files in one location, if they are enabled

"" Whitespace
set list                          " Show invisibles, display tabs as '▸   ', trailing spaces as '•'
set listchars=tab:▸\ ,trail:•     " Show some whitespace that should never be used
set tabstop=8                     " The one true tab width. (According to Kernighan and Pike)
set shiftwidth=2                  " But doesn't mean I want everything indented to tabstop.
set expandtab                     " Use spaces instead of tabs because we're not a monster
set ttyfast                       " smoother output, we're not on a 1200 dialup :)
set mouse=a                       " It's 2015 (or later) we have mice

if !has("mac")
  "" Put yanked text in a global clipboard so I can copy between instances like
  "" a normal person. This breaks mac though, so not there
  "" set clipboard=unnamedplus
endif

" ignore on completions, used by command-t at least, likely others
set wildignore+=.git
set wildignore+=vendor/bundle/**
set wildignore+=log/**
set wildignore+=tmp/**

set foldmethod=manual             " I don't always fold code, but when I do, I do it manually

" Themes
set background=dark
set t_Co=256    " This helps in terminal mode for colors to be better
