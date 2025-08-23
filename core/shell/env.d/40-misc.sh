# Miscellaneous environment configuration

# SDKMAN configuration
export SDKMAN_DIR="/home/alex/.sdkman"
[[ -s "/home/alex/.sdkman/bin/sdkman-init.sh" ]] && source "/home/alex/.sdkman/bin/sdkman-init.sh"

# ntfy integration
if command -v ntfy >/dev/null 2>&1; then
    eval "$(ntfy shell-integration --longer-than 180)"
    export AUTO_NTFY_DONE_IGNORE="xcircle nano vim npm xc"
fi

# JetBrains configuration
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"
if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then 
    source "${___MY_VMOPTIONS_SHELL_FILE}"
fi

# Cursor IDE
export PATH="/opt/cursor:$PATH"
