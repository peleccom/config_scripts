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
    ssh \
    sudo \
    python3 \
    python3-pip \
    fontconfig \
    shellcheck \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir setuptools wheel
# Create test user and prepare directories
RUN useradd -m -s /bin/zsh testuser \
    && echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /home/testuser/config_scripts /home/testuser/.local/bin \
    && chown -R testuser:testuser /home/testuser

# Switch to test user
USER testuser
WORKDIR /home/testuser/

# Copy configuration files
COPY --chown=testuser:testuser . /home/testuser/config_scripts/


# Lite version
FROM base AS lite
ENV CONTAINER_TYPE=lite \
    CONTAINER_NAME=config-test-lite
RUN config_scripts/install/install.sh --lite \
    && rm -rf /home/testuser/.cache \
    && sudo rm -rf /tmp/* /var/tmp/*

# Full version with development tools
FROM base AS full
ENV CONTAINER_TYPE=full \
    CONTAINER_NAME=config-test-full
RUN config_scripts/install/install.sh --full \
    && rm -rf /home/testuser/.cache \
    && sudo rm -rf /tmp/* /var/tmp/*

# Set shell options and default command
SHELL ["/bin/zsh", "-l", "-c"]
CMD ["/bin/zsh", "-l"]