runtime! archlinux.vim
filetype off

" manage plugins using Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
" tlib and mw-utils are snippets dependencies
Plugin 'tomtom/tlib_vim'
Plugin 'vim-addon-mw-utils'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
call vundle#end()

filetype plugin indent on
syntax on

" general options
colorscheme tomokai
set cindent
set expandtab
set ignorecase
set textwidth=79
set incsearch
set shiftwidth=2
set tabstop=2
set number
set autoread
set mouse=a
set nobackup
set nowritebackup
set noswapfile
set backspace=2
set history=700
set undolevels=700
set cursorline
set viminfo ^=%
set laststatus=2
set spelllang=en
set showmode

set statusline=
" status line flags (modified, readonly, help)
set statusline+=%3*%m%1*%r%4*%h
" filename
set statusline+=%7*%f
" full path
set statusline+=%8*\ %F
" align to right
set statusline+=%=
" spell check notifier
set statusline+=%2*\ %{&spell!='spell'?&spelllang.'\ spellcheck\ ':''}
" current register
set statusline+=%7*\ %{v:register}
" encoding
set statusline+=\ \|\ %{&fileformat}
set statusline+=\ \|\ %{&fileencoding}
" file type
set statusline+=\ \|\ %Y\ \|
" cursor position
set statusline+=\ %3p%%\ \|\ %4l:%-3c

" easier indentation
vnoremap < <gv
vnoremap > >gv

" easier window navigation
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" return to last pos
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

let mapleader = ","

" sort
vnoremap <Leader>s :sort<CR>

" resize windows without ctrl
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

nnoremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F6>

nmap <silent> <F2> :NERDTreeToggle<CR>
