# Git Configuration Troubleshooting Guide

## Common Issues and Solutions

### 1. Permission Denied (publickey)

#### Symptoms
- `Permission denied (publickey)` error when trying to access Git repository
- Unable to clone, push, or pull

#### Solutions

1. Check SSH key permissions:
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/config
   chmod 600 ~/.ssh/*/id_rsa*
   ```

2. Verify SSH agent:
   ```bash
   # List loaded keys
   ssh-add -l

   # Clear agent and add correct key
   ssh-add -D
   ssh-add ~/.ssh/my/id_rsa
   ```

3. Test SSH connection:
   ```bash
   ssh -Tv git@github.com-personal
   ```

### 2. Wrong Identity Used

#### Symptoms
- Commits show wrong author name/email
- Pushes use wrong SSH key

#### Solutions

1. Check Git configuration:
   ```bash
   # Show all Git config
   git config --list --show-origin

   # Set correct email for repository
   git config user.email "correct@email.com"
   git config user.name "Correct Name"
   ```

2. Verify SSH configuration:
   ```bash
   # Show effective SSH config
   ssh -G github.com-personal

   # Ensure IdentitiesOnly is set
   grep "IdentitiesOnly yes" ~/.ssh/config
   ```

### 3. Multiple Keys Conflict

#### Symptoms
- Wrong SSH key being used
- Authentication fails despite correct setup

#### Solutions

1. Use specific host aliases:
   ```ssh-config
   # In ~/.ssh/config
   Host github.com-personal
       HostName github.com
       IdentityFile ~/.ssh/my/id_rsa
       IdentitiesOnly yes
   ```

2. Clear and reload SSH agent:
   ```bash
   ssh-add -D                    # Remove all keys
   ssh-add ~/.ssh/my/id_rsa     # Add specific key
   ```

### 4. Repository Remote Issues

#### Symptoms
- Unable to push/pull
- Wrong repository access

#### Solutions

1. Check remote configuration:
   ```bash
   # Show remotes
   git remote -v

   # Update remote URL
   git remote set-url origin git@github.com-personal:username/repo.git
   ```

2. Verify repository access:
   ```bash
   # Test SSH access
   ssh -T git@github.com-personal

   # Try fetching
   git fetch --verbose
   ```

### 5. Migration Issues

#### Symptoms
- Problems after switching from legacy to new system
- Inconsistent behavior

#### Solutions

1. Backup and reset:
   ```bash
   # Backup existing configs
   cp ~/.ssh/config ~/.ssh/config.backup
   cp ~/.gitconfig ~/.gitconfig.backup

   # Run setup script again
   ./ssh-config/setup-git-config.sh
   ```

2. Update repository configurations:
   ```bash
   # Update remote URL format
   git remote set-url origin git@github.com-personal:username/repo.git

   # Verify changes
   git remote -v
   ```

## Debug Commands

### SSH Debugging

```bash
# Test SSH connection with debugging
ssh -Tv git@github.com-personal

# Show effective SSH config
ssh -G github.com-personal

# Check SSH agent
ssh-add -l
```

### Git Debugging

```bash
# Show all Git config
git config --list --show-origin

# Show remote info
git remote -v
git remote show origin

# Check Git operations with debugging
GIT_SSH_COMMAND="ssh -v" git fetch
```

### File Permissions

```bash
# Check SSH directory permissions
ls -la ~/.ssh/

# Check key permissions
ls -la ~/.ssh/*/id_rsa*

# Fix common permission issues
find ~/.ssh -type d -exec chmod 700 {} \;
find ~/.ssh -type f -exec chmod 600 {} \;
```

## Recovery Steps

If everything else fails:

1. Backup existing configuration:
   ```bash
   mkdir ~/ssh-backup
   cp -r ~/.ssh/* ~/ssh-backup/
   cp ~/.gitconfig ~/ssh-backup/
   ```

2. Reset SSH configuration:
   ```bash
   rm ~/.ssh/config
   ./ssh-config/setup-git-config.sh
   ```

3. Test with a new repository:
   ```bash
   git clone git@github.com-personal:username/test-repo.git
   cd test-repo
   git config --list
   ```

4. If issues persist:
   - Check GitHub/GitLab SSH key settings
   - Verify network connectivity
   - Contact system administrator for firewall issues
