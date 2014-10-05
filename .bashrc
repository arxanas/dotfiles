#!/bin/bash

source ~/.profile

alias ..="cd ..; l;"

# vim doesn't use correct colors unless tmux takes the -2 option.
alias tmux="tmux -2"

if command -v hub >/dev/null; then
    # Use hub instead of git.
    alias git="hub"
fi

# Switch to a clean PS1, for whatever reason.
alias clean_ps1="PS1=\"\\\$ \""

# Current directory, followed by bold yellow "$". We don't want to do this if
# we're using zsh, since that will have a much fancier PS1.
if [[ -z "$ZSH_VERSION" ]]; then
    export PS1="\w \[$(tput bold)\]\[$(tput setaf 3)\]$\[$(tput sgr0)\] "
fi

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

            current_dir="$(dirname $current_dir)"
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

cd()
{
    if [[ -n "$VIRTUAL_ENV" && -z "$@" ]]; then
        builtin cd "${VIRTUAL_ENV%$VENV_NAME}"
    else
        builtin cd "$@"
    fi

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

# Lets you put a .profile in any directory. If bash starts in that directory
# (for example, because you opened a new window in tmux), and it has

# AUTOLOAD_PROFILE_FILENAME=".profile"
# if [ AUTOLOAD_PROFILE -a -e "$AUTOLOAD_PROFILE_FILENAME" -a "$(pwd)" != "$HOME" ]; then
#     AUTOLOAD_PROFILE_OK=$(head -1 "$AUTOLOAD_PROFILE_FILENAME")
#     if [ "$AUTOLOAD_PROFILE_OK" == "# autoloaded profile" ]; then
#         echo "$(tput setaf 3)$(tput bold)Notice:$(tput sgr0) Loading profile..."
#         source "$AUTOLOAD_PROFILE_FILENAME"
#     else
#         echo "$(tput setaf 1)$(tput bold)Warning:$(tput sgr0) profile in this directory exists but is not safe to load."
#     fi
# fi

export ANDROID_HOME=/usr/local/opt/android-sdk
source ~/.homebrew_github_api_token

export NVM_DIR="/Users/Waleed/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
