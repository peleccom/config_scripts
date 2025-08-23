# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load shell-agnostic configurations first
DOTFILES="$HOME/config_scripts"
source "$DOTFILES/core/shell/env.sh"
source "$DOTFILES/core/shell/aliases.sh"

# Load bash-specific configurations
for config_file in "$DOTFILES/core/bash/"*.sh; do
    if [ -f "$config_file" ]; then
        source "$config_file"
    fi
done

# Load local bash-specific configurations if they exist
if [ -d "$DOTFILES/local/bash" ]; then
    for config_file in "$DOTFILES/local/bash/"*.sh; do
        if [ -f "$config_file" ]; then
            source "$config_file"
        fi
    done
fi

# Enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
