#!/bin/bash

# Start Home Assistant proxy
# Usage: pel_proxy_hass.sh [port]
port="${1:-8123}"
ssh -L "${port}:localhost:${port}" homeassistant.local