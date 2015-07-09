#!/bin/bash
source baex.bash

zsh(){
doc <<EOD

    zsh
    -----

    * Install (via curl) oh-my-zsh
    * Enables git plugin
    * Creates a zshrc.pt with vim-promptline sourcing on it
    * If not already on ~/.zshrc, adds a line sourcing it

EOD
eval $endoc

    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo 'plugins=(git)' > ~/.zshrc.pt
    echo 'source ~/.prompt.pt' >> ~/.zshrc.pt
    grep .zshrc.pt ~/.zshrc || echo "source ~/.zshrc.pt" >> ~/.zshrc
}

bash(){

doc <<EOD

    bash
    -----

    This code actually:
    
    * Creates a bashrc.pt with vim-promptline sourcing on it
    * If not already on ~/.bashrc, adds a line sourcing it

EOD
eval $endoc

    echo 'source ~/.prompt.pt' >> ~/.bashrc.pt
    grep .bashrc.pt ~/.bashrc || echo "source ~/.bashrc.pt" >> ~/.bashrc
}

get_vim_lines(){
doc <<EOD

    get_vim_lines
    -------------

    Executes vim promptline and tmuxline plugins to get the configs.

EOD
eval $endoc

    vim -c ":PromptlineSnapshot ~/.prompt.pt airline"
    vim -c ":Tmuxline airline" -c ":TmuxlineSnapshot ~/.tmux.pt"
}

try_spf13(){
doc <<EOD

    try_spf13
    ---------

    tries to install required plugins using spf13-vim

EOD
eval $endoc

    echo -e "Bundle \'edkolev/tmuxline.vim\'\nBundle \'edkolev/promptline.vim\'\nBundle \'bling/vim-airline\'" > ~/.vimrc.bundles.local
    vim +BundleInstall
}

tmux(){
doc <<EOD

    bash
    -----

    This code actually:
    
    * Creates a bashrc.pt with vim-promptline sourcing on it
    * If not already on ~/.bashrc, adds a line sourcing it

    TODO: Do this =)

EOD
eval $endoc


}

try_spf13
get_vim_lines
zsh
bash
tmux
