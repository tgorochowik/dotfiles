set statusline=
" status line flags (modified, readonly, help)
set statusline+=%3*%m%1*%r%4*%h
" filename
set statusline+=%7*%f
" full path
set statusline+=%8*\ %<%F
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
