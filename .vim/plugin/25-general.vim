" Leave the command you typed at the bottom of the screen.
set showcmd

" Use markers to form folds.
set foldmethod=marker

" Allow buffers to be hidden.
set hidden

" Show the full list of autocompletions when trying to tab-complete command in
" command mode, rather than cycling through completions.
set wildmenu
set wildmode=list:longest:full

" Use case exactly as-is when autocompleting.
set noinfercase

" Enable mouse support in the terminal.
set mouse=a

" Use line numbering.
set number

" Makes searches case-insensitive unless you include a capital letter.
set ignorecase
set smartcase

" Open new windows at the bottom and right instead of the top and left.
" set splitbelow
set splitright

" Don't wrap text.
set nowrap

" ...except for in comments, with this magical snippet stolen from CAEN.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

" Center cursor during scrolling.
set scrolloff=1000
