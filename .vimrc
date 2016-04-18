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

"indents
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


"sort
vnoremap <Leader>s :sort<CR>


colorscheme molokai
"spellchecking
set spelllang=pl

"rezize windows without ctrl
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif


nnoremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F6>
set showmode


"let Tlist_Use_Right_Window = 1
"filetype on
"nnoremap <silent> <F3> :TlistToggle<CR>
nmap <silent> <F2> :NERDTreeToggle<CR>


"map <Leader>g :call RopeGotoDefinition()<CR>
"let ropevim_enable_shortcuts = 1
"let g:pymode_rope_goto_def_newwin = "vnew"
"let g:pymode_rope_extended_complete = 1
"let g:pymode_breakpoint = 0
"let g:pymode_syntax = 1
"let g:pymode_virtualenv = 1
"
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete
"
"let g:SuperTabDefaultCompletionType = "context"
