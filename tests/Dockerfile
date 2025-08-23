# Multi-stage build for different test environments
ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE} AS base

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    DOCKER_CONTAINER="1" \
    SHELL=/bin/zsh \
    TERM=xterm-256color \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true \
    PATH="/home/testuser/.local/bin:${PATH}" \
    CONTAINER_TYPE="test" \
    CONTAINER_NAME="config-test"

# Install basic dependencies and fonts
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    ssh \
    sudo \
    zsh \
    python3 \
    python3-pip \
    fontconfig \
    shellcheck \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir setuptools wheel \
    # Install Nerd Font
    && curl -fL https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf -o /usr/local/share/fonts/DroidSansMNerdFont-Regular.otf \
    && fc-cache -fv

# Create test user and prepare directories
RUN useradd -m -s /bin/zsh testuser \
    && echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /home/testuser/config_scripts /home/testuser/.local/bin \
    && chown -R testuser:testuser /home/testuser

# Create container indicator files
RUN echo '#!/bin/bash\necho -e "\033[1;33m⚠️  You are in a test container environment ⚠️\033[0m"\necho -e "Type: \033[1;36m$CONTAINER_TYPE\033[0m"\necho -e "Name: \033[1;36m$CONTAINER_NAME\033[0m\n"' > /etc/update-motd.d/99-container-notice \
    && chmod +x /etc/update-motd.d/99-container-notice \
    && echo '[[ -f /etc/update-motd.d/99-container-notice ]] && /etc/update-motd.d/99-container-notice' >> /etc/zsh/zshrc

# Switch to test user
USER testuser
WORKDIR /home/testuser/config_scripts

# Copy configuration files
COPY --chown=testuser:testuser . /home/testuser/config_scripts/


# Lite version
FROM base AS lite
ENV CONTAINER_TYPE=lite \
    CONTAINER_NAME=config-test-lite
RUN ./install/install.sh --lite \
    && rm -rf /home/testuser/.cache \
    && sudo rm -rf /tmp/* /var/tmp/*

# Full version with development tools
FROM base AS full
ENV CONTAINER_TYPE=full \
    CONTAINER_NAME=config-test-full
RUN ./install/install.sh --full \
    && echo "Running error handling tests..." \
    && zsh -l ./tests/test_error_handling.sh || { echo "Tests failed!"; exit 1; } \
    && rm -rf /home/testuser/.cache \
    && sudo rm -rf /tmp/* /var/tmp/*

# Set shell options and default command
SHELL ["/bin/zsh", "-l", "-c"]
CMD ["/bin/zsh", "-l"]