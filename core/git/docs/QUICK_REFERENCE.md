# Git Configuration Quick Reference

## SSH Config-based Solution (Recommended)

### Setup

```bash
# Run setup script
./ssh-config/setup-git-config.sh
```

### Common Commands

```bash
# Clone repositories
git clone git@github.com-personal:username/repo.git  # Personal
git clone git@github.com-work:username/repo.git      # Work

# Update existing remote
git remote set-url origin git@github.com-personal:username/repo.git

# Test connections
ssh -T git@github.com-personal
ssh -T git@github.com-work

# Check configurations
git config --list
ssh -G github.com-personal
```

### File Locations

- SSH Config: `~/.ssh/config`
- Personal Git Config: `~/.gitconfig-personal`
- Work Git Config: `~/.gitconfig-work`
- SSH Keys:
  - Personal: `~/.ssh/my/id_rsa`
  - Work: `~/.ssh/work/id_rsa`

## Legacy Solution (Deprecated)

```bash
# Clone repository
git-as.sh ~/.ssh/my/id_rsa clone git@github.com:username/repo.git

# Push changes
git-as.sh ~/.ssh/work/id_rsa push origin main

# Any Git command
git-as.sh ~/.ssh/my/id_rsa <command> <args>
```

## Quick Fixes

### Permission Issues
```bash
# Fix SSH directory permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/*/id_rsa*

# Clear SSH agent
ssh-add -D
```

### Wrong Identity
```bash
# Check current Git identity
git config user.email

# Set correct identity
git config user.email "correct@email.com"
```

### Debug Commands
```bash
# Test SSH with verbose output
ssh -Tv git@github.com-personal

# Show effective SSH config
ssh -G github.com-personal

# List SSH keys in agent
ssh-add -l
```
