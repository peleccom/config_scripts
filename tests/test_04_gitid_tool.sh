#!/bin/bash

set -e
set -u

# Test pel_gitid tool
test_gitid_tool() {
    echo "Testing pel_gitid tool..."

    # Make tool executable
    chmod +x ~/config_scripts/bin/pel_gitid

    # Add tool to PATH
    export PATH="$HOME/config_scripts/bin:$PATH"

    # Create test directory
    TEST_DIR=$(mktemp -d)
    cd "$TEST_DIR"

    # Initialize test repository
    git init
    git config --global init.defaultBranch main

    # Test identity creation
    echo "Testing identity creation..."
    pel_gitid create test test@example.com

    # Verify SSH config
    if ! grep -q "github.com-test" ~/.ssh/config; then
        echo "SSH config not updated correctly"
        return 1
    fi

    # Verify key generation
    if [ ! -f ~/.ssh/test/id_rsa ]; then
        echo "SSH key not generated"
        return 1
    fi

    # Test identity listing
    echo "Testing identity listing..."
    if ! pel_gitid list | grep -q "github.com-test"; then
        echo "Identity listing failed"
        return 1
    fi

    # Test identity switching
    echo "Testing identity switching..."
    git remote add origin git@github.com:test/repo.git
    pel_gitid switch github.com-test

    # Verify identity switch
    if ! git config user.email | grep -q "test@example.com"; then
        echo "Identity switch failed"
        return 1
    fi

    # Test current identity
    echo "Testing current identity display..."
    if ! pel_gitid current | grep -q "test@example.com"; then
        echo "Current identity display failed"
        return 1
    fi

    # Clean up
    rm -rf "$TEST_DIR"
    echo "pel_gitid tool tests passed"
    return 0
}

# Run tests
test_gitid_tool
