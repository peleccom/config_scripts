#!/bin/sh
# Make ssh proxy for remote hass
# Usage ./pel_proxy_hass.sh <SSH_HOST> <SSH_PORT>

ssh -L 8123:localhost:8123 pi@$1 -p $2
