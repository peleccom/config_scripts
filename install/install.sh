#!/bin/bash

set -e
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Parse arguments
INSTALL_TYPE="full"
while [[ $# -gt 0 ]]; do
  case $1 in
    --lite)
      INSTALL_TYPE="lite"
      shift
      ;;
    --full)
      INSTALL_TYPE="full"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Common dependencies
sudo apt-get update
sudo apt-get install -y zsh curl git

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  # Update if already exists
  cd "$P10K_DIR" && git pull --ff-only
fi

# Install plugins
install_plugin() {
  local repo=$1
  local name=$(basename "$repo")
  local dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$name"
  
  if [ ! -d "$dir" ]; then
    git clone "https://github.com/$repo" "$dir"
  else
    # Update if already exists
    cd "$dir" && git pull --ff-only
  fi
}

install_plugin "zsh-users/zsh-autosuggestions"
install_plugin "zsh-users/zsh-syntax-highlighting"

# Create symbolic links
ln -sf "$DOTFILES_ROOT/core/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_ROOT/core/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# Create local config directory if it doesn't exist
mkdir -p "$DOTFILES_ROOT/local"

if [ "$INSTALL_TYPE" = "full" ]; then
  # Install additional tools for full setup
  sudo apt-get install -y tmux python3-pip autojump
  
  # Install development tools
  for module in "$SCRIPT_DIR/modules/"*.sh; do
    if [ -f "$module" ]; then
      bash "$module"
    fi
  done
fi

# Change default shell to zsh if not in Docker
if [ -z "${DOCKER_CONTAINER:-}" ] && [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
else
  # In Docker, just set SHELL variable
  export SHELL=$(which zsh)
fi

echo "Installation complete! Please log out and log back in to start using zsh."
if [ "$INSTALL_TYPE" = "lite" ]; then
  echo "Note: This is a lite installation. Some development tools were not installed."
fi