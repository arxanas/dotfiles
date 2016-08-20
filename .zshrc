#!/bin/zsh

for i in ~/.shell.d/*.zshrc; do
    source "$i"
done
