#!/bin/bash

for i in ~/.shell.d/*.bashrc; do
    source "$i";
done
