# Git Configuration Management

This directory contains tools and configurations for managing multiple Git identities and SSH keys.

## Documentation

- [Full Documentation](docs/README.md) - Comprehensive guide to all features
- [Quick Reference](docs/QUICK_REFERENCE.md) - Common commands and configurations
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Solutions to common issues

## SSH Config-based Solution (Recommended)

The new recommended way to manage multiple Git identities uses SSH config files. This approach:
- Is more maintainable and standard
- Supports multiple Git hosts (GitHub, GitLab, etc.)
- Integrates better with Git's built-in features
- Provides better security through `IdentitiesOnly`

### Setup

1. Run the setup script:
   ```bash
   ./ssh-config/setup-git-config.sh
   ```

2. Update your repository remotes:
   ```bash
   # For personal repositories
   git remote set-url origin git@github.com-personal:username/repo.git

   # For work repositories
   git remote set-url origin git@github.com-work:username/repo.git
   ```

### Configuration Files

- `~/.ssh/config`: Main SSH configuration file
- `~/.gitconfig-personal`: Git configuration for personal projects
- `~/.gitconfig-work`: Git configuration for work projects

## Legacy Solution (Deprecated)

The old solution using `git-as.sh` and `ssh-as.sh` is still available but deprecated. It will be maintained for backward compatibility but should not be used for new setups.

### Legacy Usage

```bash
# Using git-as.sh (Deprecated)
git-as.sh ~/.ssh/my/id_rsa clone git@github.com:username/repo.git
git-as.sh ~/.ssh/work/id_rsa push origin main
```

## Migration Guide

1. Set up the new configuration:
   ```bash
   ./ssh-config/setup-git-config.sh
   ```

2. Update your repository remotes:
   ```bash
   # Instead of using git-as.sh ~/.ssh/my/id_rsa ...
   git remote set-url origin git@github.com-personal:username/repo.git

   # Instead of using git-as.sh ~/.ssh/work/id_rsa ...
   git remote set-url origin git@github.com-work:username/repo.git
   ```

3. Update your workflow documentation to use the new format

The old scripts will continue to work, but new repositories should use the SSH config-based approach.
