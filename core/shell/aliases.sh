#!/bin/sh
# Shell-agnostic aliases that work in both bash and zsh

# Source all alias files
for alias_file in "$HOME/config_scripts/core/shell/aliases.d/"*.sh; do
    if [ -f "$alias_file" ]; then
        . "$alias_file"
    fi
done

# Source machine-specific aliases if they exist
if [ -d "$HOME/config_scripts/local/shell/aliases.d" ]; then
    for alias_file in "$HOME/config_scripts/local/shell/aliases.d/"*.sh; do
        if [ -f "$alias_file" ]; then
            . "$alias_file"
        fi
    done
fi
