# Git Configuration Guide

This guide provides comprehensive documentation for managing multiple Git identities and SSH keys in your development environment.

## Table of Contents

1. [Quick Start](#quick-start)
2. [SSH Config-based Solution](#ssh-config-based-solution)
3. [Legacy Solution](#legacy-solution)
4. [Migration Guide](#migration-guide)
5. [Common Use Cases](#common-use-cases)
6. [Troubleshooting](#troubleshooting)
7. [Security Best Practices](#security-best-practices)

## Quick Start

```bash
# 1. Run the setup script
./ssh-config/setup-git-config.sh

# 2. Clone repositories using the new format
git clone git@github.com-personal:username/repo.git
git clone git@github.com-work:username/repo.git
```

## SSH Config-based Solution

### Overview

The SSH config-based solution provides a maintainable way to manage multiple Git identities using standard SSH configuration files. This approach:

- Uses SSH's built-in configuration system
- Supports multiple Git hosting services
- Provides better security through identity isolation
- Integrates seamlessly with Git commands

### Directory Structure

```
~/.ssh/
├── config                 # Main SSH configuration file
├── my/                   # Personal SSH keys
│   ├── id_rsa
│   └── id_rsa.pub
└── work/                # Work SSH keys
    ├── id_rsa
    └── id_rsa.pub
```

### Configuration Files

1. SSH Config (`~/.ssh/config`):
   ```ssh-config
   # Personal GitHub
   Host github.com-personal
       HostName github.com
       User git
       IdentityFile ~/.ssh/my/id_rsa
       IdentitiesOnly yes

   # Work GitHub
   Host github.com-work
       HostName github.com
       User git
       IdentityFile ~/.ssh/work/id_rsa
       IdentitiesOnly yes
   ```

2. Git Configs:
   ```ini
   # ~/.gitconfig-personal
   [user]
       name = Your Personal Name
       email = your.personal@email.com

   # ~/.gitconfig-work
   [user]
       name = Your Work Name
       email = your.work@company.com
   ```

### Usage Examples

1. Clone repositories:
   ```bash
   # Personal projects
   git clone git@github.com-personal:username/repo.git

   # Work projects
   git clone git@github.com-work:username/repo.git
   ```

2. Update existing repositories:
   ```bash
   # Change remote URL format
   git remote set-url origin git@github.com-personal:username/repo.git
   ```

3. Verify configuration:
   ```bash
   # Test SSH connection
   ssh -T git@github.com-personal
   ssh -T git@github.com-work

   # Check Git config
   git config --list
   ```

## Legacy Solution

The legacy solution using `git-as.sh` and `ssh-as.sh` is maintained for backward compatibility.

### Usage

```bash
# Clone repository
git-as.sh ~/.ssh/my/id_rsa clone git@github.com:username/repo.git

# Push changes
git-as.sh ~/.ssh/work/id_rsa push origin main

# Run any Git command
git-as.sh ~/.ssh/my/id_rsa <command> <args>
```

## Migration Guide

1. Backup existing configuration:
   ```bash
   cp ~/.ssh/config ~/.ssh/config.backup
   cp ~/.gitconfig ~/.gitconfig.backup
   ```

2. Set up new configuration:
   ```bash
   ./ssh-config/setup-git-config.sh
   ```

3. Update repository remotes:
   ```bash
   # List current remotes
   git remote -v

   # Update remote URL
   git remote set-url origin git@github.com-personal:username/repo.git
   ```

4. Verify setup:
   ```bash
   # Test SSH connection
   ssh -T git@github.com-personal

   # Test Git operations
   git fetch
   git pull
   ```

## Common Use Cases

### Managing Multiple GitHub Accounts

1. Generate SSH keys:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/my/id_rsa -C "personal@email.com"
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/work/id_rsa -C "work@company.com"
   ```

2. Add to GitHub:
   - Copy public keys: `cat ~/.ssh/my/id_rsa.pub`
   - Add to respective GitHub accounts

3. Test connections:
   ```bash
   ssh -T git@github.com-personal
   ssh -T git@github.com-work
   ```

### Working with Different Git Hosts

Add configurations for other Git hosts:

```ssh-config
# GitLab
Host gitlab.com-personal
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/gitlab/id_rsa
    IdentitiesOnly yes

# Azure DevOps
Host ssh.dev.azure.com-work
    HostName ssh.dev.azure.com
    User git
    IdentityFile ~/.ssh/azure/id_rsa
    IdentitiesOnly yes
```

## Troubleshooting

### Common Issues

1. **Permission denied (publickey)**
   - Check key permissions: `chmod 600 ~/.ssh/*/id_rsa*`
   - Verify SSH agent: `ssh-add -l`
   - Test connection: `ssh -Tv git@github.com-personal`

2. **Wrong identity used**
   - Ensure `IdentitiesOnly yes` is set
   - Clear SSH agent: `ssh-add -D`
   - Add specific key: `ssh-add ~/.ssh/my/id_rsa`

3. **Git pushing with wrong email**
   - Check current config: `git config --list`
   - Set repository-specific email: `git config user.email "correct@email.com"`

### Debug Commands

```bash
# Test SSH configuration
ssh -Tv git@github.com-personal

# Check Git configuration
git config --list --show-origin

# Verify remote URL
git remote -v

# Check SSH agent identities
ssh-add -l
```

## Security Best Practices

1. **Key Management**
   - Use strong keys (RSA 4096 bits or ED25519)
   - Keep private keys secure
   - Use different keys for different purposes

2. **Configuration Security**
   - Set correct file permissions:
     ```bash
     chmod 700 ~/.ssh
     chmod 600 ~/.ssh/config
     chmod 600 ~/.ssh/*/id_rsa
     ```
   - Use `IdentitiesOnly yes` to prevent key leakage

3. **Best Practices**
   - Regularly rotate SSH keys
   - Use passphrase protection
   - Keep backups of keys and configurations
   - Never share private keys

4. **Monitoring**
   - Check SSH agent contents regularly
   - Review Git commit authors
   - Monitor repository access logs
