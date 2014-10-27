#!/usr/bin/env bash

# get submodules
git submodule init
git submodule update

# find dir of the script
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
    if [ ! -d "$dir/backup/vim/" ]; then
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

# bash
if [ -e ~/.bash_profile ]; then
  if [ -L ~/.bash_profile ]; then
    rm ~/.bash_profile
  else
    if [ ! -d "$dir/backup/misc/" ]; then
      mkdir "$dir/backup/misc/"
    fi
    mv ~/.bash_profile "$dir/backup/misc"
  fi
fi
ln -s "$dir/misc/.bash_profile" ~/.bash_profile

if [ -e ~/.bashrc ]; then
  if [ -L ~/.bashrc ]; then
    rm ~/.bashrc
  else
    if [ ! -d "$dir/backup/misc/" ]; then
      mkdir "$dir/backup/misc/"
    fi
    mv ~/.bashrc "$dir/backup/misc"
  fi
fi
ln -s "$dir/misc/.bashrc" ~/.bashrc

if [ -e ~/.Xdefaults ]; then
  if [ -L ~/.Xdefaults ]; then
    rm ~/.Xdefaults
  else
    if [ ! -d "$dir/backup/misc/" ]; then
      mkdir "$dir/backup/misc/"
    fi
    mv ~/.Xdefaults "$dir/backup/misc"
  fi
fi
ln -s "$dir/misc/.Xdefaults" ~/.Xdefaults
