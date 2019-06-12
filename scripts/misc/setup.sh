#!/bin/sh


#bash aliases
ln -sf  `readlink -f ../../home/.aliases` ~/

# tmux
ln -sf  `readlink -f ../../home/.tmux.conf` ~/

#zsh
sudo apt-get install fonts-powerline
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git pull
cd ~

ln -sf  `readlink -f ../../home/.zshrc` ~/

#sublime text3
mkdir -p ~/.config/sublime-text-3/Packages/
rm -rf ~/.config/sublime-text-3/Packages/User
ln -sf `readlink -f ../../home/.config/sublime-text-3/Packages/User/` ~/.config/sublime-text-3/Packages/
