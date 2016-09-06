"" YCM
" Don't ask every time to load the.ycm_extra_conf.py file.
let g:ycm_confirm_extra_conf = 0
" Close the preview (docs) window after autocompleting.
let g:ycm_autoclose_preview_window_after_completion = 1
" Also close it when leaving insert mode, so that it doesn't stay open all the
" time.
let g:ycm_autoclose_preview_window_after_insertion = 1
" Use global conf file.
let g:ycm_global_ycm_extra_conf = '~/.local/dotfiles/.ycm_extra_conf.py'
" Let YCM know that we used Homebrew Python.
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
