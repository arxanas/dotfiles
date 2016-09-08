" Exclude files from .gitignore from Ctrl-P.
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

 " Use tags with Ctrl-P.
 let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix' , 'line', 'mixed']

nnoremap <Leader>lf :CtrlP<CR>
nnoremap <Leader>lt :CtrlPTag<CR>
