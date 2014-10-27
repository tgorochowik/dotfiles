#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vi-like shell
#set -o vi

# autocompletion
complete -cf sudo
complete -cf man

# default editor
export VISUAL="vim"
export EDITOR="vim"

# sudo aliases
if [ $UID -ne 0 ]; then
    alias svim='sudo vim'
    alias smount="sudo mount -o gid=users,fmask=113,dmask=002"
fi

# colorful manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# colorful grep
export GREP_OPTIONS='--color=auto'

# colorful ls
alias ls='ls --color=auto'

# prompt
PS1="\[\e[0;32m\]\u@\h\[\e[0;36m\]\w$ \[\e[0m\]"
