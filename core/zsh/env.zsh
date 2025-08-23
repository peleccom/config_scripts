# Core environment variables

# Add config_scripts/bin to PATH
if [ -d "$HOME/config_scripts/bin" ] ; then
    PATH="$HOME/config_scripts/bin:$PATH"
fi

# Editor configuration
export EDITOR='vim'
export VISUAL='vim'

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Default less options
export LESS='-R'

# Locale settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Python settings
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# Load local environment variables if they exist
if [[ -f "$DOTFILES/local/env.zsh" ]]; then
  source "$DOTFILES/local/env.zsh"
fi
