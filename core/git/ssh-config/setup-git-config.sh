#!/bin/bash

# Script to set up Git configurations for multiple accounts
# This is the new recommended way to manage multiple Git identities

set -e
set -u

# Default values
CONFIG_DIR="$HOME/.ssh"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d_%H%M%S)"

# Function to create SSH directory with correct permissions
setup_ssh_dir() {
    local dir="$1"
    mkdir -p "$dir"
    chmod 700 "$dir"
}

# Function to backup existing config
backup_config() {
    if [ -f "$CONFIG_DIR/config" ]; then
        cp "$CONFIG_DIR/config" "$CONFIG_DIR/config$BACKUP_SUFFIX"
        echo "Backed up existing SSH config to: $CONFIG_DIR/config$BACKUP_SUFFIX"
    fi
}

# Function to set up SSH config
setup_ssh_config() {
    # Create main .ssh directory
    setup_ssh_dir "$CONFIG_DIR"
    
    # Create directories for different accounts
    setup_ssh_dir "$CONFIG_DIR/my"
    setup_ssh_dir "$CONFIG_DIR/work"
    
    # Backup existing config
    backup_config
    
    # Copy new config
    cp "$(dirname "$0")/config" "$CONFIG_DIR/config"
    chmod 600 "$CONFIG_DIR/config"
    
    echo "SSH config has been set up successfully"
}

# Function to set up Git configurations
setup_git_config() {
    # Set up global Git configuration
    git config --global core.sshCommand "ssh -F ~/.ssh/config"
    
    # Create Git configuration for personal projects
    git config --global --add includeIf.gitdir:~/personal/.path ~/.gitconfig-personal
    cat > ~/.gitconfig-personal << EOL
[user]
    name = Your Personal Name
    email = your.personal@email.com
[core]
    sshCommand = "ssh -F ~/.ssh/config -i ~/.ssh/my/id_rsa"
EOL
    
    # Create Git configuration for work projects
    git config --global --add includeIf.gitdir:~/work/.path ~/.gitconfig-work
    cat > ~/.gitconfig-work << EOL
[user]
    name = Your Work Name
    email = your.work@company.com
[core]
    sshCommand = "ssh -F ~/.ssh/config -i ~/.ssh/work/id_rsa"
EOL
    
    echo "Git configurations have been set up successfully"
}

# Main execution
echo "Setting up SSH and Git configurations..."
setup_ssh_config
setup_git_config

echo "
Configuration complete! To use:

1. For personal repositories:
   - Clone using: git clone git@github.com-personal:username/repo.git
   - Or update existing repo remote: git remote set-url origin git@github.com-personal:username/repo.git

2. For work repositories:
   - Clone using: git clone git@github.com-work:username/repo.git
   - Or update existing repo remote: git remote set-url origin git@github.com-work:username/repo.git

Note: The old git-as.sh and ssh-as.sh scripts are still available but deprecated.
      Consider migrating to this new configuration-based approach.
"
