# Testing Configuration Scripts

This guide explains how to test your configuration scripts using our Docker-based testing tools.

## Quick Start

```bash
# Test full configuration
test-config

# Test lite configuration
test-config --type lite

# Interactive testing session
test-config -i

# Use different base image
test-config --image ubuntu:20.04
```

## Testing Tools

### test-config

The `test-config` tool creates a temporary Docker container to test your configuration scripts in isolation.

#### Features

- Clean environment for each test
- Support for both lite and full installations
- Interactive testing mode
- Custom base image support
- Automatic cleanup

#### Usage

```bash
test-config [options]

Options:
  --type {lite,full}    Installation type (default: full)
  --image IMAGE         Base Docker image (default: ubuntu:22.04)
  -i, --interactive     Run container in interactive mode
  -k, --keep           Keep temporary files after exit
```

#### Examples

1. Test full installation:
   ```bash
   test-config
   ```

2. Test lite installation:
   ```bash
   test-config --type lite
   ```

3. Interactive testing session:
   ```bash
   test-config -i
   ```

4. Test with different Ubuntu version:
   ```bash
   test-config --image ubuntu:20.04
   ```

5. Keep temporary files for debugging:
   ```bash
   test-config -k
   ```

## Testing Best Practices

### 1. Regular Testing

- Test after making configuration changes
- Test both lite and full installations
- Test with different base images
- Use interactive mode for debugging

### 2. Interactive Testing

Use interactive mode (-i) when:
- Debugging installation issues
- Testing user experience
- Verifying specific features
- Exploring configurations

### 3. Debugging

1. Keep temporary files:
   ```bash
   test-config -k
   ```

2. Check Docker logs:
   ```bash
   docker logs config-test-[PID]
   ```

3. Interactive debugging:
   ```bash
   test-config -i
   ```

### 4. Common Issues

1. Permission Issues
   - Check file permissions in your configuration
   - Verify user setup in container
   - Check mounted volume permissions

2. Network Issues
   - Verify Docker network settings
   - Check proxy configurations
   - Test external dependencies

3. Installation Failures
   - Review installation logs
   - Check package dependencies
   - Verify script permissions

## Continuous Integration

### GitHub Actions Example

```yaml
name: Test Configurations

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        type: [lite, full]
        ubuntu: [20.04, 22.04]

    steps:
      - uses: actions/checkout@v2
      - name: Test configuration
        run: |
          ./bin/test-config --type ${{ matrix.type }} --image ubuntu:${{ matrix.ubuntu }}
```

## Security Considerations

1. Mount configurations as read-only
2. Use temporary containers
3. Clean up after testing
4. Don't mount sensitive files
5. Use secure base images

## Extending the Testing Framework

### Adding New Test Cases

1. Create test script in `tests/`
2. Update test runner
3. Add to CI pipeline
4. Document new tests

### Custom Test Environments

1. Create custom Dockerfile
2. Add specific dependencies
3. Configure environment variables
4. Test specific scenarios
