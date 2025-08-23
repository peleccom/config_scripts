#!/bin/bash

set -e
set -u

# Test ZSH configuration
test_zsh_configuration() {
    # Source zsh configuration
    source ~/.zshrc

    # Check if PATH includes config_scripts/bin
    if [[ ":$PATH:" != *":$HOME/config_scripts/bin:"* ]]; then
        echo "config_scripts/bin is not in PATH"
        return 1
    fi

    # Check if environment variables are set
    if [ -z "${EDITOR:-}" ]; then
        echo "EDITOR environment variable is not set"
        return 1
    fi

    # Check if local configurations are loaded
    if [ -f "$HOME/config_scripts/local/env.zsh" ]; then
        source "$HOME/config_scripts/local/env.zsh"
        # Add specific tests for local configurations here
    fi

    # Test alias loading
    if ! type "git" > /dev/null; then
        echo "Git aliases not loaded"
        return 1
    fi

    return 0
}

# Run tests
test_zsh_configuration
