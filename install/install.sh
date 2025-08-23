#!/bin/bash

set -e
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Detect OS
OS="linux"
if [[ "$(uname)" == "Darwin" ]]; then
  OS="macos"
fi

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

# Install package manager and common dependencies
if [[ "$OS" == "macos" ]]; then
  # Install Homebrew if not installed
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi
  # Install common dependencies
  brew install zsh curl git
else
  # Linux dependencies
  sudo apt-get update
  sudo apt-get install -y zsh curl git
fi

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
install_zsh_plugin() {
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

install_zsh_plugin "zsh-users/zsh-autosuggestions"
install_zsh_plugin "zsh-users/zsh-syntax-highlighting"

# Create symbolic links
ln -sf "$DOTFILES_ROOT/core/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_ROOT/core/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# Create local config directory if it doesn't exist
mkdir -p "$DOTFILES_ROOT/local"

if [ "$INSTALL_TYPE" = "full" ]; then
  # Install additional tools for full setup
  if [[ "$OS" == "macos" ]]; then
    brew install tmux python3 autojump fzf
  else
    sudo apt-get install -y tmux python3-pip autojump fzf
  fi

  # Set up Python paths
  if [[ "$OS" == "macos" ]]; then
    # Use Homebrew's Python
    PYTHON_BIN_PATH="$(brew --prefix)/bin"
    export PATH="$PYTHON_BIN_PATH:$PATH"
  fi

  # Install argcomplete and ensure its scripts are in PATH
  python3 -m pip install --user argcomplete

  # Add local bin to PATH if not already there
  USER_LOCAL_BIN="$HOME/.local/bin"
  if [[ ":$PATH:" != *":$USER_LOCAL_BIN:"* ]]; then
    export PATH="$USER_LOCAL_BIN:$PATH"
  fi

  # Install argcomplete global completion
  if command -v activate-global-python-argcomplete &> /dev/null; then
    activate-global-python-argcomplete --user
  else
    echo "Warning: activate-global-python-argcomplete not found in PATH"
    echo "Current PATH: $PATH"
    echo "Try running: python3 -m argcomplete.easy_install --user"
  fi
  
  # Install development tools
  for module in "$SCRIPT_DIR/modules/"*.sh; do
    if [ -f "$module" ]; then
      bash "$module"
    fi
  done
fi

# Change default shell to zsh if not in Docker
if [ -z "${DOCKER_CONTAINER:-}" ] && [ "$SHELL" != "$(which zsh)" ]; then
  if [[ "$OS" == "macos" ]]; then
    # macOS requires sudo and the full path in /etc/shells
    ZSH_PATH="$(which zsh)"
    if ! grep -q "$ZSH_PATH" /etc/shells; then
      echo "$ZSH_PATH" | sudo tee -a /etc/shells
    fi
    chsh -s "$ZSH_PATH"
  else
    chsh -s $(which zsh)
  fi
else
  # In Docker, just set SHELL variable
  export SHELL=$(which zsh)
fi

echo "Installation complete! Please log out and log back in to start using zsh."
if [ "$INSTALL_TYPE" = "lite" ]; then
  echo "Note: This is a lite installation. Some development tools were not installed."
fi