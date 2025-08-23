# Container segment for p10k
function prompt_container() {
  if [[ -n "${DOCKER_CONTAINER}" ]]; then
    local container_type="${CONTAINER_TYPE:-container}"
    # Use orange color (208) for container indicator
    p10k segment -f 208 -i '🐳' -t "[${container_type}]"
  fi
}

# Keep existing prompt elements but add container indicator
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # Line 1
  os_icon                 # os identifier
  container              # container indicator (custom)
  dir                    # current directory
  vcs                    # git status
  # Line 2
  newline                # \n
  prompt_char           # prompt symbol
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # Line 1
  status                  # exit code
  command_execution_time  # duration
  background_jobs         # presence of background jobs
  direnv                  # direnv status
  asdf                    # asdf version manager
  virtualenv             # python virtual environment
  anaconda               # conda environment
  pyenv                  # python environment
  goenv                  # go environment
  nodenv                 # node.js version
  nvm                    # node.js version
  nodeenv                # node.js environment
  node_version           # node.js version
  go_version             # go version
  rust_version           # rustc version
  dotnet_version         # .net version
  php_version            # php version
  laravel_version        # laravel php framework version
  java_version           # java version
  package               # name@version from package.json
  rbenv                  # ruby version
  rvm                    # ruby version
  fvm                    # flutter version management
  luaenv                 # lua version
  jenv                   # java version
  plenv                  # perl version
  perlbrew               # perl version
  phpenv                 # php version
  scalaenv               # scala version
  haskell_stack          # haskell version
  kubecontext            # current kubernetes context
  terraform              # terraform workspace
  aws                    # aws profile
  aws_eb_env             # aws elastic beanstalk environment
  azure                  # azure account name
  gcloud                 # google cloud cli account and project
  google_app_cred        # google application credentials
  toolbox                # toolbox name
  context                # user@hostname
  nordvpn               # nordvpn connection status
  ranger                 # ranger shell
  nnn                    # nnn shell
  xplr                   # xplr shell
  vim_shell              # vim shell indicator
  midnight_commander     # midnight commander shell
  nix_shell              # nix shell
  todo                   # todo items
  timewarrior            # timewarrior tracking status
  taskwarrior            # taskwarrior task count
  time                   # current time
  # Line 2
  newline
)

# Container segment styling
typeset -g POWERLEVEL9K_CONTAINER_FOREGROUND=208
typeset -g POWERLEVEL9K_CONTAINER_BACKGROUND=0

# Customize colors and icons
typeset -g POWERLEVEL9K_CONTAINER_VISUAL_IDENTIFIER_EXPANSION='🐳'
typeset -g POWERLEVEL9K_CONTAINER_VISUAL_IDENTIFIER_COLOR=208

# Make the container segment stand out
typeset -g POWERLEVEL9K_CONTAINER_BACKGROUND=0
typeset -g POWERLEVEL9K_CONTAINER_FOREGROUND=208

# Add padding around the container segment
typeset -g POWERLEVEL9K_CONTAINER_LEFT_PADDING=1
typeset -g POWERLEVEL9K_CONTAINER_RIGHT_PADDING=1

# Keep other customizations from the original p10k config
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi