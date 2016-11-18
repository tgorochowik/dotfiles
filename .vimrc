runtime! archlinux.vim

" load plugins
runtime! plugins.vim

" load status line
runtime! statusline.vim

" load additional key mappings
runtime! keys.vim

" general options
colorscheme tomokai
set cindent
set ignorecase
set textwidth=79
set incsearch
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

" prefer two spaces indent for most files
set expandtab
set shiftwidth=2
set tabstop=2

" but kernel-like eight spaces for c
autocmd FileType c,cpp,dts setlocal noexpandtab shiftwidth=8 tabstop=8

" wrap git commit msg at 72
autocmd FileType gitcommit setlocal tw=72 colorcolumn=73 spell

" list config
set list
set listchars=tab:\ \ ,trail:\ ,

" break indent
set breakindent

" return to last pos
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" backup multi-tab session on exit
autocmd VimLeave * :if tabpagenr("$") > 1 | mksession! /tmp/.vimsession | endif
