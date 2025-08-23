# If you come from bash you might have to change your $PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

DEFAULT_USER=$(whoami)

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


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
plugins=(
  git
  docker
  docker-compose
  python
  sudo
  virtualenvwrapper
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

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


function preexec() {
    timer=${timer:-$SECONDS}
}

function precmd() {
    retVal=$?

    export RPROMPT=""
    if [ $timer ]; then
        timer_show=$(($SECONDS - $timer))
        if [ $timer_show -gt 3 ]; then
            timer_show=$(printf '%.*f\n' 3 $timer_show)
            status_code_show="" 
	    if [ $retVal -ne 0 ]; then
                status_code_show="[$retVal] : "
	    fi
            export RPROMPT="$status_code_show${timer_show}s"
            unset status_code_show
            unset timer_show
        fi
        unset timer
    fi
    unset retVal
}


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source $HOME/.aliases

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/config_scripts/bin" ] ; then
    PATH="$HOME/config_scripts/bin:$PATH"
fi

# The next line enables Android SDK
if [ -d "$HOME/Android/Sdk" ]; then
ANDROID_HOME=$HOME/Android/Sdk
ANDROID_SDK_ROOT=$ANDROID_HOME
#PATH=$PATH:$ANDROID_HOME/emulator
PATH=$PATH:$ANDROID_HOME/tools
#PATH=$PATH:$ANDROID_HOME/tools/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
fi



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/alex/.sdkman"
[[ -s "/home/alex/.sdkman/bin/sdkman-init.sh" ]] && source "/home/alex/.sdkman/bin/sdkman-init.sh"

# DART
PATH="$PATH":"$HOME/.pub-cache/bin"

# ntfy integration https://github.com/dschep/ntfy	
eval "$(ntfy shell-integration --longer-than 180)"
export AUTO_NTFY_DONE_IGNORE="xcircle nano vim npm xc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh


# pricehubble
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

source $HOME/work/pricehubble/ph_iap_tunnel.sh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export PATH="/opt/cursor:$PATH"
plugin=(
  pyenv
)

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/aliaksandr/apps/google-cloud-sdk/path.zsh.inc' ]; then . '/home/aliaksandr/apps/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/aliaksandr/apps/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/aliaksandr/apps/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/home/aliaksandr/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# git autocomplete
autoload -Uz compinit && compinit
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi



# TWO
# Script to auto login to the GCloud CLI
# Usage: glogin [-f] [-q]
# -f    force login
# -q    quiet mode
glogin() {
    local force=false
    local quiet=false
    local opt

    # Parse options
    while getopts ":fq" opt; do
        case ${opt} in
            f ) force=true ;;
            q ) quiet=true ;;
            \? ) echo "Usage: glogin [-f] [-q]" >&2
                 return 1 ;;
        esac
    done

    # Check whether the identity token is valid
    if ! logged_in=$(yes | gcloud auth print-identity-token --verbosity=debug 2>&1 | grep 'POST /token .* 200'); then
        force=true
    fi

    if [[ $force == true ]]; then
        # User is not logged in or forced to login via -f flag
        if [[ $quiet == false ]]; then
            echo "Logging in to Google Cloud..."
            gcloud auth login --update-adc
        else
            # Invoke login command quietly in the background
            (gcloud auth login --update-adc >/dev/null 2>&1 &)
        fi
    else
        # User is already logged in
        if [[ $quiet == false ]]; then
            account=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
            echo "Already logged in to Google Cloud as $account."
        fi
    fi
}

# The runs the script quietly in the background everytime you open a new shell (note the difference with v1 where background process was invoked at this level)
#glogin -q
# TWO
kubepodimage() {
  local prefix=$1
  local pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep "^$prefix" | head -n1)

  if [[ -z "$pod" ]]; then
    echo "❌ No pod found starting with '$prefix'"
    return 1
  fi

  kubectl get pod "$pod" -o jsonpath='{.status.containerStatuses[0].imageID}{"\n"}'
}
