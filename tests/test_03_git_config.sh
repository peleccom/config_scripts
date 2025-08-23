#!/bin/bash

set -e
set -u

# Test Git configuration setup
test_git_config() {
    echo "Testing Git configuration setup..."

    # Test SSH directory creation
    mkdir -p ~/.ssh/test
    chmod 700 ~/.ssh/test

    # Create test keys
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/test/id_rsa -N "" -C "test@example.com"

    # Copy test config
    cp ~/config_scripts/core/git/ssh-config/config ~/.ssh/config
    chmod 600 ~/.ssh/config

    # Test if config is valid
    if ! ssh -F ~/.ssh/config -T git@github.com-personal 2>&1 | grep -q "Permission denied"; then
        echo "SSH config test failed"
        return 1
    fi

    # Test Git configuration
    git config --global core.sshCommand "ssh -F ~/.ssh/config"
    if [ "$(git config --global core.sshCommand)" != "ssh -F ~/.ssh/config" ]; then
        echo "Git config test failed"
        return 1
    fi

    # Test old scripts still work
    if [ ! -f ~/config_scripts/git-as.sh ] || [ ! -f ~/config_scripts/ssh-as.sh ]; then
        echo "Old scripts not found"
        return 1
    fi

    # Make scripts executable
    chmod +x ~/config_scripts/git-as.sh ~/config_scripts/ssh-as.sh

    # Test old script execution
    if ! ~/config_scripts/git-as.sh ~/.ssh/test/id_rsa version 2>/dev/null; then
        echo "Old script test failed"
        return 1
    fi

    echo "Git configuration tests passed"
    return 0
}

# Run tests
test_git_config
