set nocompatible

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Appearance.
Plugin 'Lokaltog/vim-powerline'
Plugin 'wellsjo/wells-colorscheme.vim'

" IDE.
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'janko-m/vim-test'
Plugin 'qpkorr/vim-bufkill'

" Editing.
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'triglav/vim-visual-increment'
Plugin 'editorconfig/editorconfig-vim'

" Languages.
"" LESS.
Plugin 'groenewege/vim-less'

"" Lua.
Plugin 'xolox/vim-lua-ftplugin'

"" Coffeescript.
Plugin 'kchmck/vim-coffee-script'
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"" D.
Plugin 'JesseKPhillips/d.vim'
Plugin 'Hackerpilot/DCD', {'rtp': 'editors/vim'}
let g:dcd_path = expand('~/.vim/bundle/DCD')

"" Haskell.
Plugin 'bitc/vim-hdevtools'

"" Latex.
Plugin 'lervag/vimtex'

"" Clojure.
Plugin 'guns/vim-clojure-static'
Plugin 'vim-scripts/paredit.vim'

" Notice that this kills ,gt so you should probably fix that.
Plugin 'mhinz/vim-signify'
call vundle#end()
