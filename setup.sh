#!/bin/bash

# https://github.com/Parth/dotfiles
install() {
  # This could def use community support
  # Don't use apt, it's also a java util and might detect that
  if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get install "$@" -y

  elif [ -x "$(command -v brew)" ]; then
    brew install "$@"

  else
    echo "I'm not sure what your package manager is! Please install $@ on
    your own and run this deploy script again."
  fi
}

update_packages() {
  if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update && sudo apt-get dist-upgrade -y

  elif [ -x "$(command -v brew)" ]; then
    brew update && brew upgrade

  else
    echo "I'm not sure what your package manager is! Please update packages on
    your own and run this deploy script again."
  fi
}

check_for_software() {
  echo "Checking to see if $1 is installed"
  command=${2-"$1"}
  if ! [ -x "$(command -v "$command")" ]; then
    install "$1"
  else
    echo "$1 is installed."
  fi
}

check_default_shell() {
  if [ -z "${SHELL##*zsh*}" ]; then
    echo "Default shell is zsh."
  else
    chsh -s "$(which zsh)"
  fi
}

echo "We're going to do the following:"
echo "1. Check to make sure you have zsh, vim, and tmux installed"
echo "2. We'll help you install them if you don't"
echo "3. We're going to check to see if your default shell is zsh"
echo "4. We'll try to change it if it's not"

packages=(
  autoconf
  build-essential
  curl
  fd-find
  git
  libbz2-dev
  libdb-dev
  libffi-dev
  libgdbm-dev
  libgdbm6
  libgmp-dev
  liblzma-dev
  libncurses5-dev
  libncursesw5-dev
  libreadline-dev
  libreadline6-dev
  libsqlite3-dev
  libssl-dev
  libxml2-dev
  libxmlsec1-dev
  libyaml-dev
  patch
  pspg
  ripgrep
  rustc
  tk-dev
  tmux
  uuid-dev
  xz-utils
  zlib1g-dev
  zsh
)

update_packages

install "${packages[@]}"

# for package in "${packages[@]}"; do
#   check_for_software "${package}"
#   echo
# done

check_default_shell

if [ ! -x "$(command -v mise)" ]; then
  echo "Install mise"
  echo
  curl https://mise.run | sh
  eval "$(${HOME}/.local/bin/mise activate bash)"
else
  echo "mise already installed"
  echo
fi

mise_packages=(
  lua
  neovim
  python
  ruby
)
for package in "${mise_packages[@]}"; do
  mise plugins install -y "${package}"
  mise use --global "${package}"@latest
  echo
done

mise use --global nodejs@lts

node_packages=(
  eslint_d
  actionlint
  neovim
)

for package in "${node_packages[@]}"; do
  npm install -g "${package}"
  echo
done

pip install --upgrade pip
pip install codespell
pip install neovim

gem install neovim

if [ ! -x "$(command -v lazygit)" ]; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
fi

echo "Install oh-my-zsh"
echo
if [ ! -f "${HOME}/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/denysdovhan/spaceship-prompt.git "${HOME}/dotfiles/zsh/zsh_custom/themes/spaceship-prompt"
fi

# Ensure directory exists
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME}/.config}"
mkdir -p "${XDG_CONFIG_HOME}/nvim"
mkdir -p "${XDG_CONFIG_HOME}/alacritty"
# Nvim is configured to use this directory for swap files
mkdir -p "${HOME}/.vim/tmp"

# echo
# echo -n "Backing up old dotfiles. "
#
# mv "$HOME/.aliases" "$HOME/.aliases.old"
# mv "$HOME/.exports" "$HOME/.exports.old"
# mv "$HOME/.profile" "$HOME/.profile.old"
# mv "$HOME/.gitconfig" "$HOME/.gitconfig.old"
#
# mv "$HOME/.zshrc" "$HOME/.zshrc.old"
# mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.old"
# mv "$HOME/.vimrc" "$HOME/.vimrc.old"
# mv "${XDG_CONFIG_HOME}/nvim/init.vim" "${XDG_CONFIG_HOME}/nvim/init.vim.old"

echo
echo "Linking in other files"
ln -sf "$HOME/dotfiles/nvim/init.lua" "$XDG_CONFIG_HOME/nvim/init.lua"
ln -sf "$HOME/dotfiles/nvim/lua" "$XDG_CONFIG_HOME/nvim/lua"

# Create dot files to reference our dotfiles
echo "source $HOME/dotfiles/aliases" >"$HOME/.aliases"
echo "source $HOME/dotfiles/exports" >"$HOME/.exports"
echo "source $HOME/dotfiles/profile" >"$HOME/.profile"
printf "[include]\n  path=%s/dotfiles/gitconfig\n" "$HOME" >"$HOME/.gitconfig"
printf "#include dotfiles/Xresources\n" >"$HOME/.Xresources"

echo "source $HOME/dotfiles/zsh/zshrc" >"$HOME/.zshrc"
echo "source $HOME/dotfiles/zsh/zshenv" >"$HOME/.zshenv"
echo "source-file $HOME/dotfiles/tmux/tmux.conf" >"$HOME/.tmux.conf"

ln -sf "$HOME/dotfiles/plan" "$HOME/.plan"
ln -sf "$HOME/dotfiles/psqlrc" "$HOME/.psqlrc"
ln -sf "$HOME/alacritty.toml" "$XDG_CONFIG_HOME/alacritty/alacritty.toml"

echo
echo "Please log out and log back in for default shell to be initialized."
