" Exclude files from .gitignore from Ctrl-P.
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Use tags with Ctrl-P.
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix' , 'line', 'mixed']

" Search upward to the home directory for a tags file.
set tags+=tags;$HOME

" Set EasyTags to run asynchronously.
let g:easytags_async = 1
