#!/bin/bash

# https://github.com/Parth/dotfiles
install() {
  # This could def use community support
  # Don't use apt, it's also a java util and might detect that
  if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get install "$1" -y

  elif [ -x "$(command -v brew)" ]; then
    brew install "$1"

  # elif [ -x "$(command -v pkg)" ]; then
  #   sudo pkg install "$1"
  #
  # elif [ -x "$(command -v pacman)" ]; then
  #   sudo pacman -S "$1"

  else
    echo "I'm not sure what your package manager is! Please install $1 on
    your own and run this deploy script again. Tests for package managers are
    in the deploy script you just ran starting at line 13. Feel free to make
    a pull request at https://github.com/parth/dotfiles :)"
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
  if [ -z "${SHELL##*zsh*}" ] ;then
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
  zsh
  ripgrep
  tmux
  pspg
  git
)

for package in "${packages[@]}"; do
  check_for_software "${package}"
  echo
done

check_for_software neovim, nvim
echo

check_default_shell

git clone https://github.com/asdf-vm/asdf.git ~/.asdf
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "${HOME}/dotfiles/zsh/zsh_custom/themes/spaceship-prompt"

# Ensure directory exists
mkdir -p "${HOME}/.config/nvim"

echo
echo -n "Backing up old dotfiles. "

mv "$HOME/.aliases" "$HOME/.aliases.old"
mv "$HOME/.exports" "$HOME/.exports.old"
mv "$HOME/.profile" "$HOME/.profile.old"
mv "$HOME/.gitconfig" "$HOME/.gitconfig.old"

mv "$HOME/.zshrc" "$HOME/.zshrc.old"
mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.old"
mv "$HOME/.vimrc" "$HOME/.vimrc.old"
mv "$HOME/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim.old"

echo
echo "Linking in other files"
ln -s "$HOME/dotfiles/nvim/lua" "$XDG_CONFIG_HOME/nvim/lua"

# Create dot files to reference our dotfiles
echo "source $HOME/dotfiles/aliases" > "$HOME/.aliases"
echo "source $HOME/dotfiles/exports" > "$HOME/.exports"
echo "source $HOME/dotfiles/profile" > "$HOME/.profile"
printf "[include]\n  path=%s/dotfiles/gitconfig\n" "$HOME" > "$HOME/.gitconfig"
printf "#include dotfiles/Xresources\n" > "$HOME/.Xresources"

echo "source $HOME/dotfiles/zsh/zshrc" > "$HOME/.zshrc"
echo "source $HOME/dotfiles/zsh/zshenv" > "$HOME/.zshenv"
echo "so $HOME/dotfiles/vim/vimrc" > "$HOME/.vimrc"
echo "source-file $HOME/dotfiles/tmux/tmux.conf" > "$HOME/.tmux.conf"
echo "so $HOME/dotfiles/nvim/init.lua" > "$XDG_CONFIG_HOME/nvim/init.lua"

ln -s "$HOME/dotfiles/plan" "$HOME/.plan"
ln -s "$HOME/dotfiles/psqlrc" "$HOME/.psqlrc"

echo
echo "Please log out and log back in for default shell to be initialized."
