#!/bin/bash
# https://noamlewis.wordpress.com/2013/01/24/git-admin-an-alias-for-running-git-commands-as-a-privileged-ssh-identity/
set -e
set -u
exec ssh -o IdentitiesOnly=yes ${SSH_KEYFILE+-i "$SSH_KEYFILE"} "$@"
