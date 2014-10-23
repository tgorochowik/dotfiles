runtime! archlinux.vim
filetype off

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

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

let mapleader = ","

"indents
vnoremap < <gv
vnoremap > >gv
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

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
