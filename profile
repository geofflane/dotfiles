# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -s "$HOME/.oracle_client" ]] && source "$HOME/.oracle_client"

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# functions #
function switch() {
    echo "Switching to $1 version: $2"
    sudo rm $TOOLS/$1
    sudo ln -s $TOOLS/$2 $TOOLS/$1
    ls -latr $TOOLS/$1
}

# mkdir, cd into it #
function mkcd () {
    mkdir -p "$*"
    cd "$*"
}

alias grails20='switch "grails" "grails-2.0.3"'

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
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# RBenv rehashing
export RBENV_ROOT=`brew --prefix rbenv`
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profiles
# sources /etc/bash.bashrc).
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
