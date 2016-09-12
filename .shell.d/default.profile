export PATH='/usr/bin:/bin:/usr/sbin'

# Homebrew
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# NodeJS
export PATH="$PATH:$HOME/Waleed/node_modules/.bin"

# Python.
export PATH="$PATH:$HOME/Library/Python/3.5/bin"

# Rubygems.
export PATH="$PATH:$HOME/.gem/ruby/2.0.0/bin"

# XAMPP. For the `mysql` executable and such.
export PATH="$PATH:/Applications/XAMPP/xamppfiles/bin"

# LaTeX.
export PATH="$PATH:/usr/local/texlive/2015/bin/x86_64-darwin"

# Java.
export PATH="$PATH:/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home"

# Haskell.
export PATH="$PATH:$HOME/.cabal/bin:/Users/Waleed/Library/Haskell/bin"

# Hoogle requires custom libiconv.
export LD_LIBRARY_PATH="/usr/local/opt/libiconv/lib:$LD_LIBRARY_PATH"

# Android SDK.
export ANDROID_HOME=/usr/local/opt/android-sdk

# Homebrew's Github tokens.
source ~/.homebrew_github_api_token

# NVM (Node Version Manager).
export NVM_DIR="/Users/Waleed/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

# Pebble.
export PATH="$PATH:/usr/local/Cellar/pebble-sdk/3.2/Pebble"

# Custom utilities.
export PATH="$HOME/.local/bin:$PATH"

# nvim as editor.
export VISUAL="nvim"
export EDITOR="nvim"
