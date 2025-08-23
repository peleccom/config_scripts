#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "Installing git management tools..."

# Install gitid tool
mkdir -p "$HOME/bin"
cp "$DOTFILES_ROOT/core/git/bin/gitid" "$HOME/bin/"
chmod +x "$HOME/bin/gitid"

# Set up SSH config directory
mkdir -p "$HOME/.ssh/config.d"
chmod 700 "$HOME/.ssh" "$HOME/.ssh/config.d"

# Copy SSH config template
cp "$DOTFILES_ROOT/core/git/ssh-config/config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

echo "Git tools installation complete!"