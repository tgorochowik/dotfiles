#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from subprocess import call
from os import symlink, remove
from os.path import exists, islink, expanduser
from shutil import move


# maintained files definitions
files = {'~/.config/awesome':'awesome',
         '~/.vim'           :'vim/.vim',
         '~/.vimrc'         :'vim/.vimrc',
         '~/.bash_profile'  :'misc/.bash_profile',
         '~/.bashrc'        :'misc/.bashrc',
         '~/.Xdefaults'     :'misc/.Xdefaults'}

# get git submodules
call(["git","submodule","init"])
call(["git","submodule","update"])


# create backup dir
cdir=os.path.dirname(os.path.realpath(__file__))
backup=cdir+"/backup"

if not exists(backup):
    os.makedirs(backup)


# define install function
def install(where, what):
    what = cdir+"/"+what
    where = expanduser(where)
    if exists(where):
        if islink(where):
            remove(where)
        else:
            move(where,backup)
    symlink(what, where)


# actual installation
for x in files:
    install(x,files[x])
