#!/usr/bin/env bash

#find dir of the script

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# create backup dir
if [ ! -e "$dir/backup" ]; then
  mkdir "$dir/backup"
fi

# awesome
awesome_path=~/.config/awesome
if [ -d "$awesome_path" ]; then
  if [ -L "$awesome_path" ]; then
    rm "$awesome_path"
  else
    mv "$awesome_path" "$dir/backup/"
  fi
fi
ln -s "$dir/awesome" "$awesome_path"

# vim
vim_path=~/.vim
vimrc_path=~/.vimrc
if [ -d "$vim_path" ]; then
  if [ -L "$vim_path" ]; then
    rm "$vim_path"
  else
    if [ ! -e "$dir/backup/vim/" ]; then
      mkdir "$dir/backup/vim/"
    fi
    mv "$vim_path" "$dir/backup/vim"
  fi
fi
ln -s "$dir/vim/.vim" "$vim_path"
if [ -e "$vimrc_path" ]; then
  if [ -L "$vimrc_path" ]; then
    rm "$vimrc_path"
  else
    mv "$vimrc_path" "$dir/backup/vim"
  fi
fi
ln -s "$dir/vim/.vimrc" "$vimrc_path"
