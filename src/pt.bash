#!/bin/bash

log_icon="\e[31m✓\e[0m"
log_icon_ok="\e[32m✓\e[0m"
log_icon_nok="\e[31m✗\e[0m"
LOG=$(mktemp)

run_and_log(){
    $2 &> ${LOG} && {
        _log_icon=$log_icon_ok
        } || {
        _log_icon=$log_icon_nok
    }
    echo -e "${_log_icon} ${1}"
}

get_inconsolata_for_powerline(){
doc <<EOD

    get_inconsolata_for_powerline
    -----------------------------

    - Adds inconsolata for powerline to ~/.fonts

EOD
eval $endoc

    mkdir -p ~/.fonts
    wget -O ~/.fonts/Inconsolata\ for\ Powerline.otf https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
    fc-cache ~/.fonts

}

get_vim_lines(){
doc <<EOD

    get_vim_lines
    -------------

    Executes vim promptline and tmuxline plugins to get the configs.

EOD
eval $endoc

    vim -c ":PromptlineSnapshot ~/.prompt.pt airline" -c ":q"
    tmux new-session vim -c ":Tmuxline airline" -c ":TmuxlineSnapshot ~/.tmuxline.pt" -c ":q"
}

get_dircolors(){
doc <<EOD

    get_dircolors
    -------------

    Downloads dircolors-solarized.

EOD
eval $endoc
    wget -O ~/.dircolors.pt https://github.com/seebi/dircolors-solarized/raw/master/dircolors.256dark
}


xfce4_terminal(){
doc <<EOD

    xfce4_terminal
    --------------

    - Downloads solarized config for xfce4 temrminal and applies it.
    - Configures Inconsolata for Powerline

    .. warning::

        BE CAREFUL.
        This COMPLETLY overwrites your xfce4-terminal configuration.


EOD
eval $endoc
    mkdir -p ~/.config/xfce4/terminal
    wget https://github.com/sgerrand/xfce4-terminal-colors-solarized/raw/master/dark/terminalrc -O ~/.config/xfce4/terminal/terminalrc
    cat >> ~/.config/xfce4/terminal/terminalrc <<EOD 
    MiscAlwaysShowTabs=FALSE
    MiscBell=FALSE
    MiscBordersDefault=TRUE
    MiscCursorBlinks=FALSE
    MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
    MiscDefaultGeometry=80x24
    MiscInheritGeometry=FALSE
    MiscMenubarDefault=TRUE
    MiscMouseAutohide=FALSE
    MiscToolbarDefault=FALSE
    MiscConfirmClose=TRUE
    MiscCycleTabs=TRUE
    MiscTabCloseButtons=TRUE
    MiscTabCloseMiddleClick=TRUE
    MiscTabPosition=GTK_POS_TOP
    MiscHighlightUrls=TRUE
    ScrollingBar=TERMINAL_SCROLLBAR_NONE
    FontName=Inconsolata for Powerline Medium 16
EOD
}

xresources(){
doc <<EOD

    xresources
    ----------

    Downloads xresources solarized file, puts it into ~/.Xresources 
    (not overwriting) and reloads xresources

    .. warning::

        This APPENDS to ~/.Xresources, so you might have to clean it
        manually if something goes wrong

EOD
eval $endoc
    tmp=$(mktemp)
    wget https://raw.githubusercontent.com/altercation/solarized/master/xresources/solarized -O $tmp
    cat $tmp >> ~/.Xresources
    xrdb ~/.Xresources
}

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

    bash <(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
    echo 'plugins=(git)' > ~/.zshrc.pt
    echo 'source ~/.prompt.pt' >> ~/.zshrc.pt
    echo 'eval `dircolors ~/.dircolors.pt`' >> ~/.zshrc.pt
    grep .zshrc.pt ~/.zshrc || echo "source ~/.zshrc.pt" >> ~/.zshrc
}

install_bash(){

doc <<EOD

    install_bash
    ------------

    This code actually:
    
    * Creates a bashrc.pt with vim-promptline sourcing on it
    * If not already on ~/.bashrc, adds a line sourcing it

EOD
eval $endoc

    wget -O ~/.baex.bash https://raw.githubusercontent.com/XayOn/baex/master/src/build/baex.bash
    echo "source ~/.baex.bash" >> ~/.bashrc.pt
    echo "source ~/.prompt.pt" >> ~/.bashrc.pt
    echo 'eval `dircolors ~/.dircolors.pt`' >> ~/.zshrc.pt
    grep .bashrc.pt ~/.bashrc || echo "source ~/.bashrc.pt" >> ~/.bashrc
}

tmux(){
config=<<EOD
    set-option -g status on
    set-option -g status-interval 2
    set-option -g status-utf8 on
    set-option -g status-position top
    set-window-option -g xterm-keys on
    set -g default-command /bin/zsh
    set -g default-shell /bin/zsh
    source ~/.tmuxline.pt
    set -g mouse-select-window on
    set-option -g mouse-select-pane on
    set-option -g mouse-resize-pane
    set-option -g lock-server on
    set-option -g lock-after-time 1800
    set-option -g lock-command 'cmatrix -b -u 9'
    bind -n S-down new-window
    bind -n C-left prev
    bind -n C-right next
    bind -n C-S-left swap-window -t -1
    bind -n C-S-right swap-window -t +1
EOD

doc <<EOD

    bash
    -----

    * Creates a tmux config file.
    * If not already on ~/.tmuxrc source it.

    Adds config as

    ::

        $config

EOD
eval $endoc

    cat > ~/.tmux.pt <<EOD $config 
EOD

    grep ".tmux.pt" ~/.tmux.conf || {
        echo "source ~/.tmux.pt" >> ~/.tmux.conf
    }

}


spf13vim(){
doc <<EOD

    spf13vim
    --------

    Installs spf13-vim.

EOD

eval $endoc

    curl -fsSL https://raw.github.com/spf13/spf13-vim/3.0/bootstrap.sh | bash
    echo -e "Bundle 'edkolev/tmuxline.vim'\nBundle 'edkolev/promptline.vim'" > ~/.vimrc.bundles.local
    vim -c ":BundleInstall" -c ":qa"

}

run(){
doc <<EOD

    run main stuff
    --------------

    Runs the script

EOD

eval $endoc

    echo "Writing log in ${LOG}"
    run_and_log "Instalando spf13-vim" spf13vim
    run_and_log "Get vim promptline and tmuxline" get_vim_lines
    run_and_log "Get dircolors" get_dircolors
    run_and_log "Get inconsolata" get_inconsolata_for_powerline
    run_and_log "Make zsh config" zsh
    run_and_log "Make bash config" install_bash
    run_and_log "Make tmux config" tmux
    run_and_log "Get xresources" xresources
    run_and_log "Configure xfce4 terminal" xfce4_terminal
}

[[ "bash" != $0  ]] && run
