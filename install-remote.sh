#!/bin/sh

if [ -e ~/.dotfiles ]; then
    cd ~/.dotfiles; 
    git pull;
else
    git clone https://github.com/XayOn/dotfiles/ ~/.dotfiles
fi

# Install script
cd ~/.dotfiles
sh install.sh
