" setup mapleader
let mapleader = ","

" easier indentation
vnoremap < <gv
vnoremap > >gv

" easier window navigation
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" resize windows without ctrl
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

" easier sort
vnoremap <Leader>s :sort<CR>

" function keys
nnoremap <F6> :set invpaste paste?<CR>
set pastetoggle=<F6>

nmap <silent> <F2> :NERDTreeToggle<CR>
nmap <silent> <F3> :NERDTreeFind<CR>
nmap <silent> <F4> :UndotreeToggle<CR>
