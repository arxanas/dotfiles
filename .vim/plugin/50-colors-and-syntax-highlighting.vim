" Enable syntax highlighting.
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*
set ofu=syntaxcomplete#Complete

" Highlight trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Make colors not sickening.
set bg=dark
colorscheme wellsokai

" Search in real-time, and highlight matches.
set incsearch
set hlsearch

" Highlight other paren.
highlight MatchParen ctermbg=4
