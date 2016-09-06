" Statusline
let g:Powerline_symbols="fancy"
let g:Powerline_symbols_override = { 'BRANCH': '', 'LINE': '', 'RO': '', 'FT': ''}
let g:Powerline_dividers_override = ['', '', '', '']
set laststatus=2
set statusline=%<%f\  " Filename
set statusline+=%w%h%m%r " Options
set statusline+=[%{&ff}/%Y] " Filetype
" set statusline+=\ [%{getcwd()}]
set statusline+=[%l\ %v] " Row and column
