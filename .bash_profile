#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# auto startx on login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- vt1
