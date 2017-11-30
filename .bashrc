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
export LESS_TERMCAP_so=$'\E[01;49;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# colorful grep
alias grep='grep --color=always'

# colorful ls
alias ls='ls --color=auto'

# colorful pacman
alias pacman='sudo pacman --color=auto'

# prevent accidental reboots
alias reboot='echo nope...'

# map vi to vim
alias vi='vim'

# easier pwd copy
alias pwdcp='pwd | xargs echo -n | xclip'

alias c='clear'

# git bash completion
source /usr/share/git/completion/git-completion.bash

# add local commands to PATH
if [[ -e ~/.local/bin ]]; then
  export PATH=$(readlink -f ~/.local/bin/):$PATH
fi

# cd git root
function groot() {
  groot_dir=$(git rev-parse --show-toplevel) && cd $groot_dir
}

# better cd (if arg is file, go to its dir)
function cd() {
  local args=$@

  # just go home if no args
  if ! [[ $1 ]]; then
    command cd && return 0
  fi

  # don't do anything if just going back
  [[ $@ == "-" ]] && command cd $@ && return 0

  while (( $# )); do
    # in cd if there is a dash switch it has to come first,
    # we have to skip them all
    if [[ $1 == "-"* ]]; then
      shift
      continue
    fi

    # check the rest parameters if they form a file
    if [[ -f "$@" ]]; then
      args=${args/$@/$(dirname "$@")}

      # show what is going to happen
      echo "cd $args"
    fi
    break
  done

  # check if calculated directory exists
  [[ -e "$args" ]] && command cd "$args" && return 0

  # try to find
  IFS='  ' read -r -a parts <<< "$args"
  local n
  for n in $(seq 0  ${#parts[@]}); do
    cdir=${parts[@]:0:$n}
    [[ -e "$cdir" ]] && cd "$cdir" && return 0
  done

  # fail
  echo "bash: cd: $args: No such file or directory"
  return 1
}

function screencap() {
  # capture screen of remote android device
  if ! [[ $1 ]]; then
    echo "Filename missing"
    return 1
  fi
  adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $1
}

function python() {
  if type bpython > /dev/null 2>&1 && [[ -z "$@" ]]; then
    bpython
  else
    command python $@
  fi
}

HISTCONTROL=ignoreboth

# prompt
PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local rc="$?"
    local mc=""

    if [ "$rc" != 0 ]; then
      mc="\[\e[8;31m\]"
    fi
    PS1="\[\e[0;32m\]\u@\[\e[0;32m\]\h\[\e[0;36m\]:\w$mc$ \[\e[0m\]"
}
