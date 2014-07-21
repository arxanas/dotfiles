" Useful for things?
set nocompatible

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-powerline'
" Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'

" Notice that this kills ,gt so you should probably fix that.
" Plugin 'mhinz/vim-signify'
call vundle#end()

let g:signify_vcs_list = ['git']

" Back up stuff, but in ~/.vim instead of the current directory.
set dir=~/.vim/swapfiles

" Except when editing a crontab.
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

set undodir=~/.vim/undo
set undofile

set backupdir=~/.vim/backups
set backup
set writebackup

" Leave the command you typed at the bottom of the screen.
set showcmd

" Use markers to form folds.
set foldmethod=marker

" Allow buffers to be hidden.
set hidden

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
set bg=light

" Statusline
let g:Powerline_symbols="fancy"
let g:airline_powerline_fonts=1
set laststatus=2
set statusline=%<%f\  " Filename
set statusline+=%w%h%m%r " Options
set statusline+=[%{&ff}/%Y] " Filetype
" set statusline+=\ [%{getcwd()}]
set statusline+=[%l\ %v] " Row and column

"" YCM
" Don't ask every time to load the.ycm_extra_conf.py file.
let g:ycm_confirm_extra_conf = 1
" Close the preview (docs) window after autocompleting.
let g:ycm_autoclose_preview_window_after_completion = 1
" Also close it when leaving insert mode, so that it doesn't stay open all the
" time.
let g:ycm_autoclose_preview_window_after_insertion = 1
" Use global conf file.
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

let g:delimitMate_expand_cr = 1

" If we use 'autoindent' instead of this, autoclose refuses to indent
" correctly after typing {<CR>.
filetype indent on

" Tabbery.
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" Fix backspace issues.
set backspace=indent,eol,start

" Show the autocompletion menu.
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

" Leader is comma.
let mapleader=","

" Let ,o/,O insert a line below/above, without entering insert mode.
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Let K split lines at the cursor.
nnoremap K i<CR><Esc>

" Let ,k split the parentheses on the current line, assuming it's a
" function call.
nnoremap <Leader>k 0f(a<CR><Esc>$F)i<CR><Esc>kw>>:s/, /,\r\t/g<CR>j$

" Let ,f justify the paragraph you're in.
nnoremap <Leader>f {gq}

" Let ,j run make.
nnoremap <Leader>j :make<CR><CR>

" Use ,sa to switch to .h file.
nnoremap <Leader>sa :e %:r.h<CR>
"
" Use ,as to switch .cpp file.
nnoremap <Leader>as :e %:r.cpp<CR>

" Let ,, do nohlsearch, which removes all those annoying highlights after
" you've searched.
nnoremap <Leader><Leader> :nohls<CR>

" Let ,m go back a tab and ,. go forward a tab.
nnoremap <Leader>m :tabprevious<CR>

" Edit a file with ,e.
nnoremap <Leader>e :tab<Space>new<Space>

" Save a file with ,w.
nnoremap <Leader>w :w<CR>

" Close the file /buffer/ with ,Q -- this actually closes the file.
nnoremap <Leader>Q :bdelete<CR>

" Close the file pane with ,q.
nnoremap <Leader>q :q<CR>

" Always show the tab bar (at the top of the screen).
set showtabline=2

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

" Use <C-w><C-q> to quit as well as the default <C-w>q
nnoremap <C-W><C-Q> <C-W>q

" Use EasyMotion with ,g.
let g:EasyMotion_leader_key="<Leader>g"

" Search upward to the home directory for a tags file.
set tags+=tags;$HOME

" Search up to the home directory for a tags file.

" Don't have a delay when pressinc <ESC> to exit from insert or visual mode.
set ttimeout
set ttimeoutlen=100

" Instead of moving line-wise, move row-wise. This is different when a line is
" broken.
nmap j gj
nmap k gk

" Don't enter ex mode when pressing Q.
nnoremap Q <Nop>

" Search in real-time, and highlight matches.
set incsearch
set hlsearch

" Use w!! to sudo-write to a file.
cmap w!! w !sudo tee % >/dev/null

" Y now yanks until the end of the line, instead of the unexpected behavior of
" yanking the whole line.
nnoremap Y y$

" Highlight other paren.
highlight MatchParen ctermbg=4

