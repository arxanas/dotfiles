" Back up stuff, but in ~/.vim instead of the current directory.
set dir=~/.vim/swapfiles

" Except when editing a crontab.
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

set undodir=~/.vim/undo
set undofile

set backupdir=~/.vim/backups
set backup
set writebackup
