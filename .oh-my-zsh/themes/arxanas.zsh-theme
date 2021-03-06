setopt promptsubst
setopt promptpercent

prompt_online()
{
    if [[ "$(cashe read online-status)" == "0" ]]; then
        echo -n "%{$fg[green]%}◉%{$reset_color%}"
    else
        echo -n "%{$fg[red]%}⦿%{$reset_color%}"
    fi
}

prompt_battery()
{
    local output="$(cashe read battery-text)"
    column()
    {
        echo "$output" | cut -d',' -f"$1"
    }
    local battery_bar="$(column 1)"
    local is_charging="$(column 2)"
    local percent="$(column 3)"

    if [[ "$is_charging" == "1" ]]; then
        if [[ "$percent" == "100" ]]; then
            echo -n "%{$fg_no_bold[green]%}"
        else
            echo -n "%{$fg_no_bold[green]%}"
        fi
        echo -n "$battery_bar"
    else
        if [[ "$percent" == 100 ]]; then
            echo -n "%{$fg_no_bold[green]%}"
        elif [[ "$percent" -gt 80 ]]; then
            echo -n "%{$fg_no_bold[yellow]%}"
        elif [[ "$percent" -gt 50 ]]; then
            echo -n "%{$FG[130]%}"
        elif [[ "$percent" -gt 35 ]]; then
            echo -n "%{$fg_bold[red]%}"
        else
            echo -n "%{$fg_no_bold[red]%}"
        fi

        echo -n "$battery_bar"
    fi
    echo -n "%{$reset_color%}"
}

build_rprompt()
{
    prompt_battery
    prompt_online
}

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts
# https://gist.github.com/remy/6079223#file-remy-zsh-theme

CURRENT_BG='NONE'
readonly SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        echo -n "%{%k%}"
    fi
    echo -n "%{%f%}"
    CURRENT_BG=''
}

# Git: branch/detached head, dirty status
prompt_git() {
    local ref dirty
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ git:$(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
        if [[ -n $dirty ]]; then
            prompt_segment 130 black
        else
            prompt_segment 76 black
        fi
        echo -n "${ref/refs\/heads\// git:}"
    fi
}

# Reimplement this command because hg is slow to launch.
hg_root() {
    local current_dir="$PWD"
    while [[ "$current_dir" != '/' ]]; do
        if [[ -d "$current_dir/.hg" ]]; then
            echo "$current_dir"
            return
        fi
        current_dir=$(dirname "$current_dir")
    done
}

# Hg: current bookmark and whether dirty.
prompt_hg() {
    local hg_root=$(hg_root)
    if [[ "$hg_root" != '' ]]; then
        local bookmark_file="$hg_root"/.hg/bookmarks.current
        if [[ -f "$bookmark_file" ]]; then
            bookmark=$(<"$bookmark_file")
        else
            bookmark='<none>'
        fi

        if [[ "$INSIDE_TRAPALRM" != '1' ]]; then
            prompt_segment yellow black
        elif [[ "$(hg status)" != '' ]]; then
            prompt_segment 130 black
        else
            prompt_segment 76 black
        fi

        echo -n " hg:$bookmark"
    fi
}

prompt_virtualenv() {
    load_virtualenv

    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        prompt_segment 89 251

        local actual_name="$(basename $VIRTUAL_ENV)"
        if [[ "$actual_name" == "$VENV_NAME" ]]; then
            actual_name="$(basename $(dirname $VIRTUAL_ENV))"
        fi

        echo -n "$actual_name"
    fi
}

prompt_dir()
{
    prompt_segment 238 253
    local volume_home_dir="/Volumes/Home$HOME"
    local pwd="${PWD/#$volume_home_dir/~}"
    pwd="${pwd/#$HOME/~}"
    echo -n "$pwd "

    # Print the prompt character as yellow if the last command succeeded, or
    # red if it failed.
    echo -n "%(?.%{$fg_bold[yellow]%}.%{$fg_bold[red]%})"

    # Use a '#' if root, or '$' otherwise.
    if [[ "$EUID" == "0" ]]; then
        echo -n '#'
    else
        echo -n '$'
    fi
}

build_prompt()
{
    [[ -f '.DS_Store' ]] && rm '.DS_Store'

    prompt_git
    prompt_hg
    prompt_virtualenv
    prompt_dir
    prompt_end
    echo -n "%{$reset_color%}"
    echo -n " "
}

RPROMPT='$(build_rprompt)'
PROMPT='$(build_prompt)'
