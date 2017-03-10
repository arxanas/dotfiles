source ~/.bashrc

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="arxanas"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Don't share history between tmux tabs.
setopt noincappendhistory
setopt nosharehistory

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    github
    npm
    pip
    python
    rsync
    tmux
    vagrant
    wd
    z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Reset the most recent prompt as often as possible.
# From http://stackoverflow.com/a/17915260/344643
TMOUT=1
INSIDE_TRAPALRM=0
TRAPALRM()
{
    # Use `INSIDE_TRAPALRM` to notify expensive prompt-drawing operations that
    # they can take longer to run (since they won't be blocking the rendering
    # of the main prompt). Also, if they take too long to run, don't have them
    # keep queuing up; instead, wait for the currently-running instance to
    # finish before launching a new one.
    if [[ "$INSIDE_TRAPALRM" == 1 ]]; then
        return
    fi

    INSIDE_TRAPALRM=1
    zle reset-prompt
    INSIDE_TRAPALRM=0
}
