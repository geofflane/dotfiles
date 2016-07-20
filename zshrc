# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Override the custom directory so I can store all my customizations in my own config git
ZSH_CUSTOM=~/.config-files/zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="dogenpunk"
ZSH_THEME=geoff

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(aws brew battery bundler cabal colored-man gem git go heroku lein nvm osx postgres rails rake ruby rbenv tmux)

source ~/.config-files/exports

source $ZSH/oh-my-zsh.sh

# Do it after oh-my-zsh or your CDPATH and other goodies will be clobbered
source ~/.config-files/aliases

# don't overwrite files with > redirection by default
setopt noclobber

# If I misspell something, correct it
setopt correct

autoload -U zmv
alias mmv='noglob zmv -W'
# Add the following to your ~/.bashrc or ~/.zshrc
#
# Alternatively, copy/symlink this file and source in your shell.  See `hitch --setup-path`.


export NVM_DIR="/Users/geoff/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
