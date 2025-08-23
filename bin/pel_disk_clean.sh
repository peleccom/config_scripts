#!/bin/bash

# Clean up docker
docker system prune -f

# Clean up apt
sudo apt-get clean
sudo apt-get autoremove -y

# Clean up snap
sudo snap set system refresh.retain=2
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read -r snapname revision; do
        sudo snap remove "$snapname" --revision="$revision"
    done

# Clean up journal
sudo journalctl --vacuum-time=3d

# Clean up thumbnails
rm -rf "$HOME/.cache/thumbnails"/*

# Clean up old kernels
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | 
    xargs sudo apt-get -y purge