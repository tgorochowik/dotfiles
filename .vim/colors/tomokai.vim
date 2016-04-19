" Vim color file
"
" Author: tkgk
"
" Note: Based on the original molokai theme by
" Tomas Restrepo <tomas@winterdom.com>
" Wimer Hazenberg
" Hamish Stuart Macpherson

hi clear

set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="tomokai"

hi Boolean         ctermfg=135
hi Character       ctermfg=144
hi Number          ctermfg=135
hi String          ctermfg=144
hi Conditional     ctermfg=161             cterm=bold
hi Constant        ctermfg=135             cterm=bold
hi Cursor          ctermfg=16  ctermbg=253
hi Debug           ctermfg=225             cterm=bold
hi Define          ctermfg=81
hi Delimiter       ctermfg=241

hi Directory       ctermfg=118             cterm=bold
hi Error           ctermfg=219 ctermbg=89
hi ErrorMsg        ctermfg=199 ctermbg=16  cterm=bold
hi Exception       ctermfg=118             cterm=bold
hi Float           ctermfg=135
hi FoldColumn      ctermfg=67  ctermbg=16
hi Folded          ctermfg=67  ctermbg=16
hi Function        ctermfg=118
hi Identifier      ctermfg=208
hi Ignore          ctermfg=244 ctermbg=232
hi IncSearch       ctermfg=193 ctermbg=16

hi Keyword         ctermfg=161             cterm=bold
hi Label           ctermfg=229             cterm=none
hi Macro           ctermfg=193
hi SpecialKey      ctermfg=81

hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
hi ModeMsg         ctermfg=229
hi MoreMsg         ctermfg=229
hi Operator        ctermfg=161

" complete menu
hi Pmenu           ctermfg=15  ctermbg=238 cterm=none
hi PmenuSel        ctermfg=15  ctermbg=235 cterm=none
hi PmenuSbar                   ctermbg=232
hi PmenuThumb      ctermfg=81

hi PreCondit       ctermfg=118             cterm=bold
hi PreProc         ctermfg=118
hi Question        ctermfg=81
hi Repeat          ctermfg=161             cterm=bold
hi Search          ctermfg=253 ctermbg=66

" marks column
hi SignColumn      ctermfg=118 ctermbg=235
hi SpecialChar     ctermfg=161             cterm=bold
hi SpecialComment  ctermfg=245             cterm=bold
hi Special         ctermfg=81  ctermbg=232
hi SpecialKey      ctermfg=245

hi Statement       ctermfg=161             cterm=bold
hi StatusLine      ctermfg=238 ctermbg=253
hi StatusLineNC    ctermfg=244 ctermbg=232
hi StorageClass    ctermfg=208
hi Structure       ctermfg=81
hi Tag             ctermfg=161
hi Title           ctermfg=166
hi Todo            ctermfg=231 ctermbg=232 cterm=bold

hi Typedef         ctermfg=81
hi Type            ctermfg=81              cterm=none
hi Underlined      ctermfg=244             cterm=underline

hi VertSplit       ctermfg=244 ctermbg=232 cterm=bold
hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=235
hi WarningMsg      ctermfg=231 ctermbg=238 cterm=bold
hi WildMenu        ctermfg=81  ctermbg=16

hi Normal          ctermfg=252 ctermbg=233
hi Comment         ctermfg=59
hi CursorLine                  ctermbg=234 cterm=none
hi CursorColumn                ctermbg=234
hi LineNr          ctermfg=250 ctermbg=234
hi NonText         ctermfg=250 ctermbg=234

" tabs
hi TabLineFill                 ctermfg=238
hi TabLine         ctermfg=15  ctermbg=238 cterm=none
hi TabLineSel      ctermfg=15  ctermbg=235 cterm=none

" diff
hi DiffAdd                     ctermbg=17
hi DiffAdded    ctermfg=150
hi DiffRemoved  ctermfg=174
hi DiffAdd      ctermfg=233    ctermbg=61
hi DiffDelete   ctermfg=233    ctermbg=240 cterm=none
hi DiffChange   ctermfg=233    ctermbg=181
hi DiffText     ctermfg=233    ctermbg=174 cterm=none
if &diff
hi CursorLine   ctermfg=252    ctermbg=236 cterm=none
hi CursorColumn ctermfg=252    ctermbg=236 cterm=none
endif

" color extra whitespace characters
autocmd InsertLeave * match ExtraWhite /\s\+$\|^	\+/
autocmd InsertEnter * match ExtraWhite /\s\+$\|^	\+/
hi ExtraWhite                 ctermbg=235

" user colors (for statusline)
hi User1        ctermfg=1     ctermbg=236
hi User2        ctermfg=2     ctermbg=236
hi User3        ctermfg=3     ctermbg=236
hi User4        ctermfg=4     ctermbg=236
hi User5        ctermfg=5     ctermbg=236
hi User6        ctermfg=6     ctermbg=236
hi User7        ctermfg=7     ctermbg=236
hi User8        ctermfg=240   ctermbg=236
