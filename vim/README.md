# vimrc
my vim config

# Getting started
## Install dependencies

* exuberant-ctags - `apt install exuberant-ctags`
* the_silver_searcher (ag) - `apt install silversearcher-ag` for ack
* eslint - `npm install eslint -g` for syntastic
* `pip install neovim` for deoplete # or pip3 install neovim depending wht the python3 pip is called

## Get the config
Checkout project into ~/.vim

## Install dein for plugin management

`curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh`
`sh ./installer.sh ~/.cache/dein`


## Run vim

`:call dein#install()`

WOW!
