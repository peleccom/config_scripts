#!/bin/sh
# Shell-agnostic environment variables that work in both bash and zsh

# Load machine-specific environment file if it exists
if [ -f "$HOME/config_scripts/local/shell/env.local" ]; then
    . "$HOME/config_scripts/local/shell/env.local"
fi

# Source all environment files
for env_file in "$HOME/config_scripts/core/shell/env.d/"*.sh; do
    if [ -f "$env_file" ]; then
        . "$env_file"
    fi
done

# Source machine-specific environment files if they exist
if [ -d "$HOME/config_scripts/local/shell/env.d" ]; then
    for env_file in "$HOME/config_scripts/local/shell/env.d/"*.sh; do
        if [ -f "$env_file" ]; then
            . "$env_file"
        fi
    done
fi
