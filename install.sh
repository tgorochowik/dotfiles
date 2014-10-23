#!/usr/bin/env bash

#find dir of the script

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#awesome

if [ ! -e "$DIR/backup" ]; then
  mkdir "$DIR/backup"
fi

awesome_path=~/.config/awesome

if [ -d "$awesome_path" ]; then
  if [ -L "$awesome_path" ]; then
    rm "$awesome_path"
  else
    mv "$awesome_path" "$DIR/backup"
  fi
fi

ln -s "$DIR/awesome" "$awesome_path"
