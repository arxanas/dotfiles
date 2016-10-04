call plug#begin('~/.vim/plugged')

" Appearance.
Plug 'vim-airline/vim-airline'
Plug 'wellsjo/wells-colorscheme.vim'

" IDE.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'janko-m/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
" Plug 'neomake/neomake'
Plug '~/Workspace/vimscript/neomake'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'zchee/deoplete-jedi'

" Editing.
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'

" Languages.
"" LESS.
Plug 'groenewege/vim-less'

"" Lua.
Plug 'xolox/vim-misc' | Plug 'xolox/vim-lua-ftplugin'

"" Coffeescript.
Plug 'kchmck/vim-coffee-script'
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"" D.
Plug 'JesseKPhillips/d.vim'
Plug 'Hackerpilot/DCD', {'rtp': 'editors/vim'}
let g:dcd_path = expand('~/.vim/bundle/DCD')

"" Haskell.
Plug 'bitc/vim-hdevtools'

"" Latex.
Plug 'lervag/vimtex'

"" Clojure.
Plug 'guns/vim-clojure-static'
Plug 'vim-scripts/paredit.vim'

call plug#end()
