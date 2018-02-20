filetype off

" manage plugins using Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mglb/vim-indenty'
Plugin 'godlygeek/tabular'
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()

filetype plugin indent on
syntax on

" snippets
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsExpandTrigger = "<c-j>"

" indenty
let g:indenty_msg_hl = ""
let g:indenty_detailed_msg = 1
