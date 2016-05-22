#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# auto startx on login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 && -z $TMUX ]] && exec startx
