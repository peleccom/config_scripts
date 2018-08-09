#!/bin/sh


#bash aliases
ln -sf  `readlink -f ../../home/.aliases` ~/

# tmux
ln -sf  `readlink -f ../../home/.tmux.conf` ~/

#sublime text3
mkdir -p ~/.config/sublime-text-3/Packages/
rm -rf ~/.config/sublime-text-3/Packages/User
ln -sf `readlink -f ../../home/.config/sublime-text-3/Packages/User/` ~/.config/sublime-text-3/Packages/
