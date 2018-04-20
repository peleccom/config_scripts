#!/bin/bash

# https://noamlewis.wordpress.com/2013/01/24/git-admin-an-alias-for-running-git-commands-as-a-privileged-ssh-identity/
set -e
set -u

SSH_KEYFILE_NAME=$1
SCRIPTS_DIR=$(dirname $0)
shift	

SSH_KEYFILE=$SSH_KEYFILE_NAME GIT_SSH=$SCRIPTS_DIR/ssh-as.sh git $@
