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
nnoremap <Leader>f gwip
inoremap <Leader>f <Esc>gwipi
vnoremap <Leader>f gw

" Use ,sa to switch to .h file.
nnoremap <Leader>sa :e %:r.h<CR>
"
" Use ,as to switch .cpp file.
nnoremap <Leader>as :e %:r.cpp<CR>

" Let ,, do nohlsearch, which removes all those annoying highlights after
" you've searched.
nnoremap <Leader><Leader> :nohls<CR>

" Edit a file with ,e.
nnoremap <Leader>e :edit<Space>

" Save a file with ,w.
nnoremap <Leader>w :w<CR>

" Save and make with ,m
nmap <Leader>m ,w:silent !make<CR>:redraw!<CR>

" Open NERDTree with ,n.
nmap <Leader>n :NERDTreeToggle<CR>

" Toggle paste and nopaste mode with ,p.
set pastetoggle=<Leader>p

" Open buffer-switching.
nnoremap <Leader>b :b

" Close the file /buffer/ with ,q -- this actually closes the file.
nnoremap <Leader>q :bdelete<CR>

nnoremap <Leader>] :TagbarOpen fjc<CR>
nnoremap <Leader>lf :CtrlP<CR>
nnoremap <Leader>lt :CtrlPTag<CR>

nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tv :TestVisit<CR>

" Use EasyMotion with ,g.
let g:EasyMotion_leader_key="<Leader>g"

" Use <C-w><C-q> to quit as well as the default <C-w>q
nnoremap <C-W><C-Q> <C-W>q

" Don't have a delay when pressinc <ESC> to exit from insert or visual mode.
set ttimeout
set ttimeoutlen=100

" Instead of moving line-wise, move row-wise. This is different when a line is
" broken.
nmap j gj
nmap k gk

" Don't enter ex mode when pressing Q.
nnoremap Q <Nop>

" Use w!! to sudo-write to a file.
cmap w!! w !sudo tee % >/dev/null

" Y now yanks until the end of the line, instead of the unexpected behavior of
" yanking the whole line.
nnoremap Y y$
