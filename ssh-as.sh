#!/bin/bash
# DEPRECATED: This script is maintained for backward compatibility.
# Please use the new SSH config based approach in core/git/ssh-config for new setups.
# See core/git/README.md for migration instructions.
#
# Original source:
# https://noamlewis.wordpress.com/2013/01/24/git-admin-an-alias-for-running-git-commands-as-a-privileged-ssh-identity/
set -e
set -u
exec ssh -o IdentitiesOnly=yes ${SSH_KEYFILE+-i "$SSH_KEYFILE"} "$@"
