#!/bin/bash

source ~/.profile

# vim doesn't use correct colors unless tmux takes the -2 option.
alias tmux="tmux -2"

# Parallelize `make` by default.
alias make="make -j5"

# Open multiple files in panes.
alias vim="vim -O"

# don't add commands starting with a space to history
export HISTCONTROL="ignorespace"

# Run nethack with no bones
alias nethack="rm -f /usr/games/lib/nethackdir/bon*.Z; /usr/games/bin/nethack"

# added by travis gem
[ -f /Users/Waleed/.travis/travis.sh ] && source /Users/Waleed/.travis/travis.sh
