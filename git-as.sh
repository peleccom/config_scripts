#!/bin/bash

# https://noamlewis.wordpress.com/2013/01/24/git-admin-an-alias-for-running-git-commands-as-a-privileged-ssh-identity/
set -e
set -u
set -x
set -v
SSH_KEYFILE=$1 GIT_SSH_COMMAND=${BASH_SOURCE%/*}/ssh-as.sh exec git "${@:2}"
