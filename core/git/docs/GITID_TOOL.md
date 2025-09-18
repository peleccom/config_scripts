# pel_gitid - Git Identity Management Tool

A versatile command-line tool for managing multiple Git identities across different Git servers and repositories.

## Quick Start

```bash
# Create a new identity
pel_gitid create personal personal@email.com

# Create identity for another Git server
pel_gitid create work work@company.com --host gitlab.company.com

# List configured identities
pel_gitid list

# Switch identity using direct name (sets up git-as integration)
pel_gitid switch work    # Uses ~/.ssh/work/id_rsa

# Switch identity using full host name
pel_gitid switch gitlab.company.com-work

# Show current identity
pel_gitid current

# Apply identity configuration to current repository
pel_gitid apply work
```

## Commands

### Create Identity

Create a new Git identity with SSH key:

```bash
pel_gitid create <name> <email> [--host server.com] [--key-type rsa] [--key-bits 4096]

# Examples:
pel_gitid create personal personal@email.com
pel_gitid create work work@company.com --host gitlab.company.com
```

The create command will:
1. Generate SSH key pair
2. Configure SSH settings
3. Create user configuration script
4. Set up Git config file

### List Identities

Show all configured Git identities:

```bash
pel_gitid list
```

### Switch Identity

Switch to a different identity in the current repository. You can use either a direct identity name or a full host-based identity:

```bash
# Using direct identity name (sets up git-as integration)
pel_gitid switch work    # Uses ~/.ssh/work/id_rsa
pel_gitid switch my      # Uses ~/.ssh/my/id_rsa

# Using full host-based identity
pel_gitid switch gitlab.company.com-work
```

When using direct identity names (`work` or `my`):
- Sets up git alias for the identity (e.g., `git work` for work identity)
- Configures git to use the correct SSH key
- Loads identity-specific configuration if available
- Integrates with git-as.sh for SSH key management

### Show Current Identity

Display the current Git identity for the repository:

```bash
pel_gitid current
```

### Apply Identity Configuration

Apply an identity's configuration to the current repository:

```bash
pel_gitid apply <identity-name>

# Example:
pel_gitid apply work  # Applies work identity's email and name
```

This command:
1. Loads the identity's user.sh script
2. Applies the email and name configuration
3. Shows the current identity after applying

### Set Repository Name

Set a custom name for the current repository:

```bash
pel_gitid set-name "Custom Name"
```

## Examples

### Setting Up Multiple Git Server Identities

1. Create identities:
   ```bash
   # GitHub identity
   pel_gitid create github-personal personal@email.com
   
   # GitLab identity
   pel_gitid create gitlab-work work@company.com --host gitlab.company.com
   
   # Bitbucket identity
   pel_gitid create bitbucket-dev dev@email.com --host bitbucket.org
   ```

2. Add SSH keys to respective servers:
   ```bash
   cat ~/.ssh/github-personal/id_rsa.pub    # Add to GitHub
   cat ~/.ssh/gitlab-work/id_rsa.pub        # Add to GitLab
   cat ~/.ssh/bitbucket-dev/id_rsa.pub      # Add to Bitbucket
   ```

3. Test connections:
   ```bash
   ssh -T git@github.com-personal
   ssh -T git@gitlab.company.com-work
   ssh -T git@bitbucket.org-dev
   ```

### Managing Repository Identity

1. Clone with specific identity:
   ```bash
   git clone git@gitlab.company.com-work:company/project.git
   cd project
   pel_gitid current  # Verify identity
   ```

2. Switch identity:
   ```bash
   # Using direct identity name
   pel_gitid switch work

   # Or using full host name
   pel_gitid switch github.com-personal
   ```

3. Apply identity configuration:
   ```bash
   pel_gitid apply personal  # Apply personal identity's email and name
   ```

4. Set repository-specific name:
   ```bash
   pel_gitid set-name "John Doe (Project Lead)"
   ```

5. Verify configuration:
   ```bash
   pel_gitid current
   git remote -v
   ```

## Troubleshooting

### Wrong Identity Used

```bash
# Check current identity
pel_gitid current

# Switch to correct identity
pel_gitid switch gitlab.company.com-work

# Verify remote URL
git remote -v
```

### SSH Key Issues

```bash
# Test SSH connection
ssh -T git@gitlab.company.com-work

# Check SSH configuration
ssh -G gitlab.company.com-work
```

### Permission Issues

```bash
# Fix permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod -R 600 ~/.ssh/*/id_rsa*
chmod 700 ~/.ssh/*/user.sh
```

## Integration

The `pel_gitid` tool is automatically installed during the full setup:

```bash
# Manual installation
cp bin/pel_gitid ~/bin/
chmod +x ~/bin/pel_gitid
```

## Security

- Each identity has its own:
  - SSH key pair
  - User configuration script
  - Git config file
- Keys are stored in separate directories
- Strict file permissions are enforced
- `IdentitiesOnly yes` prevents key leakage