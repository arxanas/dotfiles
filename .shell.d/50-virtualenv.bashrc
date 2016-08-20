#!/bin/bash

export VENV_NAME=".venv"
# Search upward looking for a virtualenv directory.
_find_virtualenv()
{
    local current_dir="$PWD"
    while [[ "$current_dir" != "/" ]]; do
        local search_dir="$current_dir/$VENV_NAME"
        if [[ -d "$search_dir" ]]; then
            echo "$search_dir"
            return 0
        fi

        current_dir=$(dirname "$current_dir")
    done
    return 1
}

load_virtualenv()
{
    if [[ -z "$VENV_NAME" ]]; then
        echo >/dev/stderr 'load_virtualenv: No $VENV_NAME, could not load virtualenvs.'
        return 1
    fi
    local virtualenv_path="$(_find_virtualenv)"
    if [[ -n "$virtualenv_path" ]]; then
        # Deactivate the previous virtualenv, if any.
        if [[ -n "$VIRTUAL_ENV" ]]; then
            deactivate
        fi

        # Use this one.
        source "$virtualenv_path/bin/activate"
    else
        # If we had a virtualenv, get rid of it.
        if [[ -n "$VIRTUAL_ENV" ]]; then
            deactivate
        fi
    fi
}
load_virtualenv

virtualenv()
{
    command virtualenv "$@"
    load_virtualenv
}

# Convenience functions for creating a new virtualenv in this directory.
alias venv2='virtualenv -p python2 "$VENV_NAME"'
alias venv3='virtualenv -p python3 "$VENV_NAME"'

cd()
{
    builtin cd "$@"
    load_profile
    load_virtualenv

    l
}

# cd to the root of whatever project is currently being worked on.
cdr() {
    local git_path
    git_path=$(git rev-parse --show-toplevel)
    if [[ "$?" == '0' ]]; then
        cd "$git_path"
        return
    fi

    local virtualenv_path
    virtualenv_path=$(_find_virtualenv)
    if [[ "$?" == '0' ]]; then
        cd "$virtualenv_path"
        return
    fi

    cd
}
