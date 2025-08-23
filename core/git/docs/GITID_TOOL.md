# gitid - Git Identity Management Tool

A simple command-line tool for managing multiple Git identities.

## Quick Start

```bash
# Create a new identity
gitid create personal personal@email.com

# List configured identities
gitid list

# Switch identity in a repository
gitid switch github.com-personal

# Show current identity
gitid current
```

## Commands

### Create Identity

Create a new Git identity with SSH key:

```bash
gitid create <name> <email> [--key-type rsa] [--key-bits 4096]

# Example:
gitid create work work@company.com
```

### List Identities

Show all configured Git identities:

```bash
gitid list
```

### Switch Identity

Switch to a different identity in the current repository:

```bash
gitid switch <identity>

# Example:
gitid switch github.com-work
```

### Show Current Identity

Display the current Git identity for the repository:

```bash
gitid current
```

## Examples

### Setting Up Personal and Work Identities

1. Create identities:
   ```bash
   gitid create personal personal@email.com
   gitid create work work@company.com
   ```

2. Add SSH keys to GitHub:
   ```bash
   cat ~/.ssh/personal/id_rsa.pub  # Add to personal GitHub
   cat ~/.ssh/work/id_rsa.pub      # Add to work GitHub
   ```

3. Test connections:
   ```bash
   ssh -T git@github.com-personal
   ssh -T git@github.com-work
   ```

### Managing Repository Identity

1. Clone with specific identity:
   ```bash
   git clone git@github.com-work:company/project.git
   cd project
   gitid current  # Verify identity
   ```

2. Switch identity:
   ```bash
   gitid switch github.com-personal
   ```

3. Verify configuration:
   ```bash
   gitid current
   git remote -v
   ```

## Troubleshooting

### Wrong Identity Used

```bash
# Check current identity
gitid current

# Switch to correct identity
gitid switch github.com-personal

# Verify remote URL
git remote -v
```

### SSH Key Issues

```bash
# Test SSH connection
ssh -T git@github.com-personal

# Check SSH configuration
ssh -G github.com-personal
```

### Permission Issues

```bash
# Fix permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod -R 600 ~/.ssh/*/id_rsa*
```

## Integration

The `gitid` tool is automatically installed during the full setup:

```bash
# Manual installation
cp core/git/bin/gitid ~/bin/
chmod +x ~/bin/gitid
```

## Security

- Each identity has its own SSH key
- Keys are stored in separate directories
- Strict file permissions are enforced
- `IdentitiesOnly yes` prevents key leakage
