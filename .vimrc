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

set cindent
set expandtab
set ic
set tw=79
set incsearch
set nu
set ruler
set shiftwidth=2
set tabstop=2
set autoread
set mouse=a
set nobackup
set nowritebackup
set noswapfile
set bs=2
set history=700
set undolevels=700
set cursorline

" statusline colors
" 1:red, 2:green, 3:yellow, 4:blue, 5:violet, 6:darkblue, 7:white, 8:gray
autocmd ColorScheme * hi User1 ctermfg=1 ctermbg=236
autocmd ColorScheme * hi User2 ctermfg=2 ctermbg=236
autocmd ColorScheme * hi User3 ctermfg=3 ctermbg=236
autocmd ColorScheme * hi User4 ctermfg=4 ctermbg=236
autocmd ColorScheme * hi User5 ctermfg=5 ctermbg=236
autocmd ColorScheme * hi User6 ctermfg=6 ctermbg=236
autocmd ColorScheme * hi User7 ctermfg=7 ctermbg=236
autocmd ColorScheme * hi User8 ctermfg=240 ctermbg=236

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

let mapleader = ","

" indents
vnoremap < <gv
vnoremap > >gv

" colorscheme: whitespace warning
autocmd ColorScheme * highlight WhiteSpaceWarning ctermbg=235
au InsertLeave * match WhiteSpaceWarning /\s\+$\|^	\+/

" colorscheme: tabs
autocmd ColorScheme * hi TabLineFill                 ctermfg=238
autocmd ColorScheme * hi TabLine         ctermfg=15  ctermbg=238   cterm=none
autocmd ColorScheme * hi TabLineSel      ctermfg=15  ctermbg=235   cterm=none

" colorscheme: completion menu
autocmd ColorScheme * hi Pmenu           ctermfg=15  ctermbg=238   cterm=none
autocmd ColorScheme * hi PmenuSel        ctermfg=15  ctermbg=235   cterm=none

" colorscheme: diff
autocmd ColorScheme * hi DiffAdd                     ctermbg=17
autocmd ColorScheme * hi diffAdded    ctermfg=150
autocmd ColorScheme * hi diffRemoved  ctermfg=174
autocmd ColorScheme * hi diffAdd      ctermfg=bg     ctermbg=61
autocmd ColorScheme * hi diffDelete   ctermfg=bg     ctermbg=240 cterm=none
autocmd ColorScheme * hi diffChange   ctermfg=bg     ctermbg=181
autocmd ColorScheme * hi diffText     ctermfg=bg     ctermbg=174 cterm=none
if &diff
autocmd ColorScheme * hi CursorLine   ctermfg=fg     ctermbg=241 cterm=none
endif

map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

"return to last pos
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo ^=%

set laststatus=2

" sort
vnoremap <Leader>s :sort<CR>

colorscheme molokai
" spellchecking
set spelllang=pl

" rezize windows without ctrl
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

nnoremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F6>
set showmode

nmap <silent> <F2> :NERDTreeToggle<CR>
