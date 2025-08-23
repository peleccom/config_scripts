# Config Scripts

[![Tests](https://github.com/peleccom/config_scripts/actions/workflows/test.yml/badge.svg)](https://github.com/peleccom/config_scripts/actions/workflows/test.yml)

A comprehensive development environment configuration management system that provides modular, secure, and maintainable configurations for multiple development scenarios.

## 🌟 Features

### Core Features
- 🔄 **Modular Configuration System**
  - Separate configurations for different tools and environments
  - Easy to extend and customize
  - Local machine-specific overrides
  
- 🔐 **Advanced Git Identity Management**
  - Multiple Git identities (personal/work)
  - Secure SSH key handling
  - Easy identity switching with `gitid` tool
  - Backward compatibility with legacy scripts

- 🐳 **Docker-based Testing**
  - Test configurations in isolated environments
  - Support for both lite and full installations
  - Automated test suite
  - Easy validation of changes

- 🚀 **Flexible Installation Options**
  - Full development environment setup
  - Lite server configuration
  - Modular component installation
  - Automated dependency management

### Additional Features
- 📦 Comprehensive ZSH configuration with Oh My Zsh
- 🔧 Custom scripts and utilities in `bin/`
- 🔒 Secure handling of sensitive information
- 📝 Extensive documentation and guides

## 📁 Directory Structure

```
config_scripts/
├── bin/                    # Executable scripts and utilities
├── core/                   # Core configuration files
│   ├── zsh/               # ZSH configuration
│   │   ├── aliases/       # Modular aliases
│   │   ├── functions/     # Custom functions
│   │   └── themes/        # Custom themes
│   ├── git/               # Git configuration
│   │   ├── ssh-config/    # SSH configuration templates
│   │   ├── bin/          # Git management tools
│   │   └── docs/         # Detailed documentation
│   └── tmux/              # Tmux configuration
├── local/                  # Local machine specific configurations
├── install/               # Installation scripts and modules
│   ├── modules/          # Modular installation components
│   └── templates/        # Configuration templates
└── tests/                 # Test framework and test cases
```

## 🚀 Quick Start

### Basic Installation

```bash
# Clone the repository
git clone git@github.com:peleccom/config_scripts.git
cd config_scripts

# Run installation script
./install/install.sh        # Full installation
# OR
./install/install.sh --lite # Lite installation
```

### Git Identity Setup

```bash
# Create a new Git identity
gitid create personal personal@email.com

# List configured identities
gitid list

# Switch identity in a repository
gitid switch github.com-personal
```

## 🔧 Configuration

### ZSH Configuration
- Modular plugin system
- Custom aliases and functions
- Theme customization
- Local overrides

### Git Configuration
- Multiple identity support
- SSH key management
- Repository-specific settings
- Legacy script compatibility

### Local Configuration
- Machine-specific settings
- Environment variables
- Custom overrides
- Sensitive information handling

## 🧪 Testing

### Running Tests

#### Quick Test in Temporary Container
```bash
# Run tests with full configuration (default)
pel_test_config

# Run tests with lite configuration
pel_test_config --type lite

# Skip tests and get interactive shell
pel_test_config -i --no-test

# Keep container and files for debugging
pel_test_config --keep

# Force rebuild container
pel_test_config --rebuild
```

#### Development Container
```bash
# Start a development container
pel_dev_config start

# Start a full development container
pel_dev_config start --type full

# Open a shell in the container
pel_dev_config shell

# Show container status
pel_dev_config status

# Clean up containers and volumes
pel_dev_config clean
```

#### Comprehensive Test Suite
```bash
cd tests
docker compose up --build   # Run all tests
docker compose run test-lite # Test lite installation
docker compose run test-full # Test full installation
```

### Running Linters Locally

We use several linters to maintain code quality:

1. **Python Linting**
```bash
# Install Python linters
pip install pylint black

# Run pylint
find . -type f -name "*.py" -exec pylint {} +

# Run black
find . -type f -name "*.py" -exec black --check {} +
```

2. **Shell Script Linting**
```bash
# Install shellcheck
sudo apt-get install shellcheck  # Ubuntu/Debian
brew install shellcheck         # macOS

# Run shellcheck
find ./bin -type f -exec shellcheck {} +
```

3. **Run All Linters**
```bash
# Using test script
pel_test_config --type lite  # Includes linting checks
```

### Test Coverage
- Installation validation
- Configuration verification
- Tool functionality
- Security checks
- Code style and quality

## 📚 Documentation

### Core Documentation
- [Git Key Management](core/git/docs/GIT_KEYS.md)
- [Quick Reference](core/git/docs/QUICK_REFERENCE.md)
- [Troubleshooting](core/git/docs/TROUBLESHOOTING.md)
- [gitid Tool Guide](core/git/docs/GITID_TOOL.md)

### Additional Resources
- [Installation Guide](install/README.md)
- [Testing Framework](tests/README.md)
- [Script Documentation](bin/README.md)

## 🔒 Security

### Key Features
- Secure key management
- Proper file permissions
- Configuration isolation
- Sensitive data protection

### Best Practices
- Use of environment variables
- Secure configuration templates
- Regular security audits
- Protected sensitive files

## 🤝 Contributing

### Guidelines
1. Fork the repository
2. Create a feature branch
3. Add tests for new features
4. Submit a pull request

### Development Setup
1. Clone the repository
2. Install development dependencies
3. Run test suite
4. Make changes
5. Verify tests pass

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Oh My Zsh community
- Docker testing inspiration
- Open source contributors

## 📞 Support

- Create an issue for bug reports
- Submit feature requests
- Check documentation for common issues
- Contact maintainers for security concerns
