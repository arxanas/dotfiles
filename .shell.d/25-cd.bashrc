#!/bin/bash

if command -v gls >/dev/null; then
    LS_COMMAND='gls --group-directories-first --color'
else
    LS_COMMAND='ls'
fi
export LS_COLORS="di=1;36:$LS_COLORS"
alias l="$LS_COMMAND -lah"
alias ..="cd ..; l;"

mc()
{
    mkdir -p "$@"
    cd "$@"
}
