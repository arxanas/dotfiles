#!/bin/bash

# Switch to a clean PS1, for whatever reason.
alias clean_ps1="PS1=\"\\\$ \""

# Current directory, followed by bold yellow "$". We don't want to do this if
# we're using zsh, since that will have a much fancier PS1.
if [[ -z "$ZSH_VERSION" ]]; then
    export PS1="\w \[$(tput bold)\]\[$(tput setaf 3)\]$\[$(tput sgr0)\] "
fi
