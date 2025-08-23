# Testing Framework

This directory contains the testing framework for the configuration system. It provides both automated tests and interactive testing environments.

## Quick Testing

### Using pel_test_config

The `pel_test_config` tool provides a quick way to test configurations in temporary containers:

```bash
# Test full configuration
pel_test_config --type full

# Test lite configuration
pel_test_config --type lite

# Interactive testing
pel_test_config -i

# Keep container and files for debugging
pel_test_config -k
```

### Development Environment

For development and debugging, you can use the development environment:

```bash
# Start a full environment
docker compose -f docker-compose.dev.yml run --rm test-full

# Start a lite environment
docker compose -f docker-compose.dev.yml run --rm test-lite
```

## Test Structure

- `Dockerfile` - Multi-stage build for test environments
- `docker-compose.yml` - Main test suite configuration
- `docker-compose.dev.yml` - Development environment configuration

## Available Tests

1. Installation Tests
   - Full installation
   - Lite installation
   - Component installation

2. Configuration Tests
   - ZSH configuration
   - Git configuration
   - Environment variables
   - Aliases

3. Tool Tests
   - gitid functionality
   - Custom scripts
   - Path configuration

## Writing Tests

When adding new tests:

1. Create test scripts in the appropriate category
2. Add test cases to the main test suite
3. Update documentation
4. Verify in both lite and full environments

## Troubleshooting

### Common Issues

1. **Missing Commands**
   - Ensure the correct installation type is used
   - Check PATH configuration
   - Verify tool installation in modules

2. **Permission Issues**
   - Check file ownership
   - Verify directory permissions
   - Ensure correct user context

3. **Configuration Issues**
   - Validate configuration files
   - Check environment variables
   - Verify file locations

### Debug Tips

1. Use `-k` flag with `pel_test_config` to keep files
2. Check container logs
3. Use interactive mode for debugging
4. Inspect mounted volumes
