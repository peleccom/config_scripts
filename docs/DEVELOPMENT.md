# Development Guide

Quick guide for testing configuration changes in Docker containers.

## Quick Test

Test your changes in a fresh container:

```bash
# Full environment (all tools available)
cd tests
pel_dev_config shell full

# Basic environment (minimal setup)
pel_dev_config shell lite
```

The container will:
- Have all configurations installed
- Mount your local changes
- Be removed when you exit

## Available Tools

Inside the container, you can use:
- `gitid` - Manage Git identities
- `pel_test_config` - Run configuration tests
- All standard shell tools
- Development tools (in full environment)

## Development Workflow

1. Make changes to configurations
2. Test in container:
   ```bash
   cd tests
   pel_dev_config shell full
   ```
3. Try your changes:
   ```bash
   # Inside container
   gitid list              # Test Git identity management
   source ~/.zshrc         # Test shell configuration
   pel_test_config --lite      # Run tests
   ```
4. Exit container (`exit` or Ctrl+D)
5. Container is automatically removed

## Troubleshooting

If container fails to start:
```bash
# Rebuild images
docker compose build --no-cache

# Remove orphaned containers
docker compose down --remove-orphans
```