# Oh My Zsh Plugin Configuration

# Plugin settings
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

# Core plugins that should be available everywhere
plugins=(
  git
  docker
  docker-compose
  python
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
  copyfile
  pip
  command-not-found
  colored-man-pages
  aliases
  alias-finder
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