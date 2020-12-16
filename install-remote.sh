#!/bin/sh

args=""

# Clone repo to ~/.prettierTerminal or update it.
if [[ "x$NOARCH" != "x" ]] ; then
   args="--exclude yay sudo";
fi

if [[ test -e ~/.prettierTerminal ]]; then
    cd ~/.prettierTerminal; 
    git pull;
else
    git clone https://github.com/XayOn/prettierTerminal/ ~/.prettierTerminal
fi

# Install script
cd ~/.prettierTerminal
sh install.sh $args
