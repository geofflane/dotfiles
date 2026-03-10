# vim: set filetype=sh:
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -s "$HOME/.exports" ]] && source "$HOME/.exports"

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# mkdir, cd into it #
function mkcd() {
  mkdir -p "$*"
  cd "$*" || exit
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  ;;
*)
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
  ;;
*) ;;
esac

# enable programmable completion features
if [[ $OSTYPE =~ ^darwin ]] && command -v brew &>/dev/null; then
  if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
  fi
elif [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
