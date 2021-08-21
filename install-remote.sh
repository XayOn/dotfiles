#!/bin/sh

if [ -e ~/.prettierTerminal ]; then
    cd ~/.prettierTerminal; 
    git pull;
else
    git clone https://github.com/XayOn/prettierTerminal/ ~/.prettierTerminal
fi

# Install script
cd ~/.prettierTerminal
sh install.sh
