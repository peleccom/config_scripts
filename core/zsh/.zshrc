# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

DEFAULT_USER=$(whoami)

# Container-specific settings
if [[ -n "${DOCKER_CONTAINER:-}" ]]; then
  # Disable p10k configuration wizard
  POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
  # Quiet instant prompt warnings
  POWERLEVEL9K_INSTANT_PROMPT=quiet
fi

# Load core configurations
DOTFILES="$HOME/config_scripts"

# Load shell-agnostic configurations first
source "$DOTFILES/core/shell/env.sh"
source "$DOTFILES/core/shell/aliases.sh"

# Plugin configuration
source "$DOTFILES/core/zsh/plugins.zsh"

# Load Oh My Zsh if it exists
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
else
    echo "Warning: Oh My Zsh not found at $ZSH/oh-my-zsh.sh"
fi

# Load zsh-specific configurations
for config_file ($DOTFILES/core/zsh/{aliases,functions}/*.zsh(N)); do
    source $config_file
done

# Load local zsh-specific configurations if they exist
for config_file ($DOTFILES/local/zsh/{aliases,functions}/*.zsh(N)); do
    source $config_file
done

# Load completion system
autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh