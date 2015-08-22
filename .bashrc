#!/bin/bash

source ~/.profile

if command -v gls >/dev/null; then
    LS_COMMAND='gls --group-directories-first --color'
else
    LS_COMMAND='ls'
fi
export LS_COLORS="di=1;36:$LS_COLORS"
alias l="$LS_COMMAND -lah"
alias ..="cd ..; l;"

# vim doesn't use correct colors unless tmux takes the -2 option.
alias tmux="tmux -2"

# Switch to a clean PS1, for whatever reason.
alias clean_ps1="PS1=\"\\\$ \""

# Current directory, followed by bold yellow "$". We don't want to do this if
# we're using zsh, since that will have a much fancier PS1.
if [[ -z "$ZSH_VERSION" ]]; then
    export PS1="\w \[$(tput bold)\]\[$(tput setaf 3)\]$\[$(tput sgr0)\] "
fi

# Timetrap -- add a 'switch' option (overriding the old one) to switch between
# sheets.
t()
{
    local mode="$1"
    local sheet="$2"

    if [[ "$mode" == "switch" ]]; then
        if [[ -z "$sheet" ]]; then
            echo >/dev/stderr 'No sheet provided.'
            return 1
        else
            shift; shift;

            command t out "$@" && command t sheet "$sheet" && command t in "$@"
        fi
    else
        command t "$@"
    fi
}

# Lets you put a .profile in any directory. If bash starts in that directory
# (for example, because you opened a new window in tmux), and it has a
# `.profile` in it.
readonly AUTOLOAD_PROFILE_FILENAME=".profile"
readonly AUTOLOAD_PROFILE_STRING='# autoload'
load_profile()
{
    if [[ "$(pwd)" != "$HOME" && -e "$AUTOLOAD_PROFILE_FILENAME" ]]; then
        local ok_to_load
        ok_to_load=$(head -1 "$AUTOLOAD_PROFILE_FILENAME")
        if [[ "$ok_to_load" == "$AUTOLOAD_PROFILE_STRING" ]]; then
            echo "$(tput setaf 3)$(tput bold)Notice:$(tput sgr0) Loading profile..."
            source "$AUTOLOAD_PROFILE_FILENAME"
        else
            echo "$(tput setaf 1)$(tput bold)Warning:$(tput sgr0) profile in this directory exists but is not safe to load."
        fi
    fi
}
load_profile

export VENV_NAME=".venv"
load_virtualenv()
{
    if [[ -z "$VENV_NAME" ]]; then
        echo >/dev/stderr 'load_virtualenv: No $VENV_NAME, could not load virtualenvs.'
        return 1
    fi

    # Search upward looking for a virtualenv directory.
    find_virtualenv()
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

    local virtualenv_path="$(find_virtualenv)"
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

cd()
{
    builtin cd "$@"
    load_profile
    load_virtualenv
}

mcd()
{
    mkdir -p "$@"
    cd "$@"
}

# Open multiple files in panes.
alias vim="vim -O"

# don't add commands starting with a space to history
export HISTCONTROL="ignorespace"

# Run nethack with no bones
alias nethack="rm -f /usr/games/lib/nethackdir/bon*.Z; /usr/games/bin/nethack"
