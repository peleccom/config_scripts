# Multi-stage build for different test environments
FROM ubuntu:22.04 AS base

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    DOCKER_CONTAINER=1 \
    SHELL=/bin/zsh \
    TERM=xterm-256color \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Install basic dependencies and fonts
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    sudo \
    zsh \
    python3 \
    python3-pip \
    fontconfig \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir setuptools wheel \
    # Install Nerd Font
    && curl -fL https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf -o /usr/local/share/fonts/DroidSansMNerdFont-Regular.otf \
    && fc-cache -fv

# Create test user and prepare directories
RUN useradd -m -s /bin/zsh testuser \
    && echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /home/testuser/config_scripts \
    && chown -R testuser:testuser /home/testuser

# Switch to test user
USER testuser
WORKDIR /home/testuser/config_scripts

# Copy configuration files
COPY --chown=testuser:testuser . /home/testuser/config_scripts/

# Create required directories
RUN mkdir -p \
    /home/testuser/config_scripts/core/shell/env.d \
    /home/testuser/config_scripts/core/shell/aliases.d \
    /home/testuser/config_scripts/local/shell/env.d \
    /home/testuser/config_scripts/local/shell/aliases.d \
    /home/testuser/.cache/p10k-testuser \
    /home/testuser/bin

# Lite version
FROM base AS lite
RUN ./install/install.sh --lite \
    && rm -rf /home/testuser/.cache \
    && sudo rm -rf /tmp/* /var/tmp/*

# Full version with development tools
FROM base AS full
RUN ./install/install.sh --full \
    && echo "Running error handling tests..." \
    && zsh -l ./tests/test_error_handling.sh || { echo "Tests failed!"; exit 1; } \
    && rm -rf /home/testuser/.cache \
    && sudo rm -rf /tmp/* /var/tmp/*

# Set shell options and default command
SHELL ["/bin/zsh", "-l", "-c"]
CMD ["/bin/zsh", "-l"]