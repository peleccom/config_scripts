# Oh My Zsh Plugin Configuration

# Plugin settings
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default


unsetopt completealiases
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Core plugins that should be available everywhere
plugins=(
  git
  docker
  docker-compose
  python
  sudo
  # virtualenvwrapper #crash zsh
  zsh-autosuggestions # git clone https://github.com/zsh-users/zsh-autosuggestions
  zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  jira
  ng
  # django  # Removed
  copyfile
  pip
  poetry
  pyenv
  npm
  nvm
  command-not-found
  tmux
  autojump
  gcloud
  npm
  colored-man-pages
  aliases
  alias-finder
  kubectl
  aws
  z
  zsh-interactive-cd
)

# Add tmux plugin only in full installation
if [[ "${INSTALL_TYPE:-full}" = "full" ]]; then
  plugins+=(tmux)
fi

# Load additional plugins based on environment
if [[ -f "$DOTFILES/local/plugins.zsh" ]]; then
  source "$DOTFILES/local/plugins.zsh"
fi

# Plugin specific settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'

# Disable complete aliases for better plugin compatibility
unsetopt completealiases
