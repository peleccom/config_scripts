# Local Configuration

This directory contains machine-specific and work-specific configurations that should not be tracked in git.

## Directory Structure

```
local/
├── bin/                    # Local/work-specific scripts
├── zsh/                    # Local ZSH configurations
│   ├── aliases/           # Work-specific aliases
│   ├── env/              # Environment variables
│   └── functions/        # Custom functions
├── git/                    # Local Git configurations
└── projects/              # Project-specific configurations
    └── example-project/   # Example project configuration
```

## Usage

1. Copy example configurations from `examples/local/`:
   ```bash
   cp -r examples/local/* local/
   ```

2. Modify configurations for your needs:
   - Add work-specific environment variables
   - Configure project-specific tools
   - Add custom scripts

3. Add project-specific scripts to `local/bin/`:
   ```bash
   mv bin/ph_* local/bin/
   ```

## Examples

### Work Configuration
```bash
# local/zsh/env/work.zsh
export WORK_PROJECT_ROOT="/path/to/work"
export WORK_TOOLS_PATH="/path/to/tools"
```

### Project Scripts
```bash
# local/bin/project_setup.sh
#!/bin/bash
# Project-specific setup script
```

## Security

- Never commit sensitive information
- Keep credentials in environment variables
- Use secure file permissions