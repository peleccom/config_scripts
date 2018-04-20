#!/bin/bash
set -e
set -u

# https://noamlewis.wordpress.com/2013/01/24/git-admin-an-alias-for-running-git-commands-as-a-privileged-ssh-identity/ 
# Run git commands as the SSH identity provided by the keyfile ~/.ssh/admin
git config --global alias.my \!"$HOME/scripts/git-as.sh ~/.ssh/my/id_rsa"
git config --global alias.work \!"$HOME/scripts/git-as.sh ~/.ssh/work/id_rsa"

