#!/bin/bash

#dpi fu (font size)
echo Xft.dpi: 102 | xrdb -merge

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# bash history - no size limit, no duplicates, instant append
HISTCONTROL=ignoreboth
shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# (?) check window size and update LINES & COLUMN env after each cmd
shopt -s checkwinsize

# colors
default="\[\033[00m\]"
root="\[\033[01;91m\]"
user="\[\033[01;37m\]"
paths="\[\033[01;34m\]"
remote_user="\[\033[01;35m\]"
remote_path="\[\033[01;36m\]"

# colorset
c0=$default
c1=$user
c2=$paths

# color prompt - no questions

# (?) If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

function set_ps1() {
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      PS1="$c1\u@\h$c0:$c2\w$c0\$ \[\e]2;\u@\h: \W\\a\]"
  else
      PS1='\u@\h:\w\$ '
  fi
}

set_ps1
#function cd() {
#  command cd "$@" || return
#  set_ps1
#}

# enable autocompletion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# aliases
alias sudo='sudo '
if [ -f $HOME/.bash_aliases ]; then
  . $HOME/.bash_aliases
fi

if [ -d $HOME/.bash_aliases.d ]; then
  for f in $HOME/.bash_aliases.d/*; do
    . $f
  done
fi

# autocomplete
if [ -f $HOME/.bash_complete ]; then
  . $HOME/.bash_complete
fi

if [ -d $HOME/.bash_complete.d ]; then
  for f in $HOME/.bash_complete.d/*; do
    . $f
  done
fi

# other custom shit
if [ -f $HOME/.bash_custom ]; then
  . $HOME/.bash_custom
fi

if [ -d $HOME/.bash_custom.d ]; then
  for f in $HOME/.bash_custom.d/*; do
    . $f
  done
fi

