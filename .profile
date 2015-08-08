# Homebrew
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# NodeJS
export PATH="$PATH:$HOME/Waleed/node_modules/.bin"

# Rubygems.
export PATH="$PATH:$HOME/.gem/ruby/2.0.0/bin"

# XAMPP. For the `mysql` executable and such.
export PATH="$PATH:/Applications/XAMPP/xamppfiles/bin"

# LaTeX.
export PATH="$PATH:/usr/local/texlive/2011/bin/x86_64-darwin"

# Java.
export PATH="$PATH:/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home"

# Android SDK.
export ANDROID_HOME=/usr/local/opt/android-sdk

# Homebrew's Github tokens.
source ~/.homebrew_github_api_token

# NVM (Node Version Manager).
export NVM_DIR="/Users/Waleed/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

# Custom utilities.
export PATH="$HOME/.local/bin:$PATH"

# vim as editor.
export VISUAL="vim"
export EDITOR="vim"
