#!/bin/sh

for i in ~/.shell.d/*.profile; do
    source "$i";
done
