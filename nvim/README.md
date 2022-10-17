# nvimrc
My neovim config

# Getting started
## Install dependencies

* exuberant-ctags - `apt install exuberant-ctags`
* the_silver_searcher (ag) - `apt install silversearcher-ag` for ack
* ripgrrep - `apt install ripgrep` for fuzzy finding
* eslint - `npm install eslint -g` for syntastic
* `pip install neovim` # or pip3 install neovim depending wht the python3 pip is called

## Install dein for plugin management

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Run vim

`PlugInstall`

WOW!
