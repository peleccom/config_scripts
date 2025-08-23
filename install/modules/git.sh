#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "Installing git management tools..."

# Set up SSH config directory if config.d doesn't exist
# .ssh directory should already exist from git installation
if [[ ! -d "$HOME/.ssh/config.d" ]]; then
    mkdir -p "$HOME/.ssh/config.d"
    chmod 700 "$HOME/.ssh/config.d"
fi

# Ensure .ssh directory has correct permissions
if [[ -d "$HOME/.ssh" ]]; then
    chmod 700 "$HOME/.ssh"
fi

# Copy SSH config template if it doesn't exist
if [[ ! -f "$HOME/.ssh/config" ]]; then
    cp "$DOTFILES_ROOT/core/git/ssh-config/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
else
    echo "SSH config file already exists, skipping..."
fi

echo "Git tools installation complete!"