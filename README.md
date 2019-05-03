Tools
---------------------
asdf:
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"



## Installation

Once the repo is cloned, execute the deploy script:
```
./deploy
```

The deploy script creates dotfiles in your home directory that source files in
your ~/dotfiles directory. This makes it easy to provide host specific changes
in those files without having to commit them to the repo.

Where that's not possible we symlink them in.


## Credits
Organizational layout inspired heavily by: https://github.com/Parth/dotfile

