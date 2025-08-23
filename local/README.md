# Local Configuration Directory

This directory contains machine-specific configurations that should not be committed to git.

## Directory Structure

- `shell/`
  - `aliases.d/` - Machine-specific shell aliases
  - `env.d/` - Machine-specific environment variables
- `git/`
  - `identities/` - Local Git identity configurations
  - `ssh/` - Local SSH keys and configurations
- `bin/` - Machine-specific scripts and binaries
- `zsh/`
  - `functions/` - Local Zsh functions
  - `themes/` - Local Zsh theme customizations

## Usage

1. Copy example files without the `.example` extension
2. Modify the copied files with your machine-specific settings
3. Do not commit your local settings to git

## Examples

```bash
# Copy environment template
cp shell/env.local.example shell/env.local

# Copy machine-specific aliases template
cp shell/aliases.d/machine.sh.example shell/aliases.d/machine.sh
```