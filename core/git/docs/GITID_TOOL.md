# pel_gitid - Git Identity Management Tool

A versatile command-line tool for managing multiple Git identities across different Git servers and repositories.

## Quick Start

```bash
# Create a new identity (GitHub)
pel_gitid create personal personal@email.com

# Create identity for another Git server
pel_gitid create work work@company.com --host gitlab.company.com

# List configured identities
pel_gitid list

# Switch identity in a repository
pel_gitid switch gitlab.company.com-work

# Show current identity
pel_gitid current

# Apply identity configuration to current repository
pel_gitid apply work

# Set repository-specific name
pel_gitid set-name "John Doe"
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

Switch to a different identity in the current repository:

```bash
pel_gitid switch <identity>

# Examples:
pel_gitid switch github.com-personal
pel_gitid switch gitlab.company.com-work
```

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

The `pel_gitid` tool is automatically installed during the full setup on both Linux and macOS:

### Linux Installation
```bash
# Manual installation
cp bin/pel_gitid ~/bin/
chmod +x ~/bin/pel_gitid
```

### macOS Installation
```bash
# Install dependencies
brew install python3

# Manual installation
cp bin/pel_gitid ~/bin/
chmod +x ~/bin/pel_gitid
```

### Command Completion

The tool supports command-line completion for identity names and hosts. To enable it:

1. Install argcomplete and ensure its scripts are in PATH:

   On Linux:
   ```bash
   # Install argcomplete in user's home directory
   pip install --user argcomplete

   # Add pip scripts to PATH if not already there
   export PATH="$HOME/.local/bin:$PATH"
   ```

   On macOS:
   ```bash
   # Install using Homebrew's Python
   python3 -m pip install --user argcomplete

   # Add pip scripts to PATH if not already there
   export PATH="$HOME/.local/bin:$PATH"
   ```

2. Enable completion globally:

   For user-specific installation:
   ```bash
   activate-global-python-argcomplete --user
   ```

   For system-wide installation:
   ```bash
   sudo activate-global-python-argcomplete
   ```

   This will enable completion for all Python scripts that support it.

Once enabled, you can use TAB completion for:
- Identity names with `pel_gitid apply <TAB>`
- Host names with `pel_gitid switch <TAB>`

## Security

- Each identity has its own:
  - SSH key pair
  - User configuration script
  - Git config file
- Keys are stored in separate directories
- Strict file permissions are enforced
- `IdentitiesOnly yes` prevents key leakage