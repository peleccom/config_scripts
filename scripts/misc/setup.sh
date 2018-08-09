#!/bin/sh


#bash aliases
ln -s  `readlink -f ../../home/.aliases` ~/

# tmux
ln -s  `readlink -f ../../home/.tmux.conf` ~/

#sublime text3
mkdir -p ~/.config/sublime-text-3/Packages/
ln -s `readlink -f ../../home/.config/sublime-text-3/Packages/User/` ~/.config/sublime-text-3/Packages/
