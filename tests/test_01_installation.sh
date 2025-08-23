#!/bin/bash

set -e
set -u

# Test basic installation
test_basic_installation() {
    echo "Testing installation in ${INSTALL_TYPE:-full} mode..."

    # Config scripts are already mounted
    cd ~/config_scripts || exit 1
    echo "Changed to config_scripts directory"

    # Make install script executable
    chmod +x install/install.sh
    echo "Made install script executable"

    # Run installation
    ./install/install.sh --"${INSTALL_TYPE:-full}"
    echo "Installation completed"

    # Check if zsh is the default shell
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        echo "ZSH is not the default shell"
        return 1
    fi

    # Check if Oh My Zsh is installed
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh My Zsh is not installed"
        return 1
    fi

    # Check if required plugins are installed
    for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
        if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/$plugin" ]; then
            echo "Plugin $plugin is not installed"
            return 1
        fi
    done

    # Check if powerlevel10k theme is installed
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        echo "Powerlevel10k theme is not installed"
        return 1
    fi

    return 0
}

# Run tests
test_basic_installation
