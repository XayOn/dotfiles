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


tmux(){
    # https://github.com/gpakosz/.tmux
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    cat <<EOF >> .tmux.conf.local
    tmux_conf_theme_left_separator_main=''
    tmux_conf_theme_left_separator_sub=''
    tmux_conf_theme_right_separator_main=''
    tmux_conf_theme_right_separator_sub=''
    tmux_conf_battery_bar_symbol_full='♥'
    tmux_conf_battery_bar_symbol_empty='·'
EOF

    cd -
}

get_sourcecode_pro(){
    # TODO
    return
}

get_icons_in_terminal(){
    # TODO
    return
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
    FontName=SourceCodePro Nerd Font Mono 14
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
    * Creates a zshrc.pt
    * If not already on ~/.zshrc, adds a line sourcing it

EOD
eval $endoc

    bash <(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/themes/powerlevel9k
    sed -i "s/robbyrussell/powerlevel9k\/powerlevel9k/g" ~/.zshrc

    cat <<EOF >~/.zshrc.pt

    plugins=(git)

    [ -f ~/.fzf.bash ] && source ~/.fzf.bash

    export TERM=xterm-256color
    export EDITOR=vim
    export PAGER=most
    export CDPATH=$CDPATH:~/devel/

    # Export ADDR
    wttr(){ curl wttr.in/~"$ADDR";}
    cheat(){ curl cheat.sh/$@;}

    alias tree="colorls -t"
    alias ls="colorls -r"
EOF

    dircolors ~/.dircolors.pt >> .zshrc.pt
    grep .zshrc.pt ~/.zshrc || echo "source ~/.zshrc.pt" >> ~/.zshrc
}


run(){
doc <<EOD

    run main stuff
    --------------

    Runs the script

EOD

eval $endoc

    echo "Writing log in ${LOG}"
    type git || sudo apt-get install git
    type vim || sudo apt-get install vim-nox
    type colorls || sudo gem install colorls
    type most || sudo apt-get install most

    run_and_log "Get dircolors" get_dircolors
    run_and_log "Get inconsolata" get_sourcecode_pro
    run_and_log "Get icons_in_terminal" get_icons_in_terminal
    run_and_log "Make zsh config" zsh
    run_and_log "Make tmux config" tmux
    run_and_log "Make vim config" vim_cfg
    run_and_log "Get xresources" xresources
    run_and_log "Configure xfce4 terminal" xfce4_terminal
}

vim_cfg(){
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cat <<EOF >> ~/.vimrc
set nocompatible
set hidden
set encoding=utf-8
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'bagrat/vim-workspace'
Plugin 'junegunn/vim-emoji'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-grepper'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'w0rp/ale'
Plugin 'mindriot101/vim-yapf'
Plugin 'davidhalter/jedi-vim'
Plugin 'ivanov/vim-ipython'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'majutsushi/tagbar'
Plugin 'janko-m/vim-test'
Plugin 'benmills/vimux'
Plugin 'edkolev/tmuxline.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'jdkanani/vim-material-theme'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'itchyny/lightline.vim'
Plugin 'embear/vim-localvimrc'
call vundle#end()

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

filetype plugin indent on

let g:enable_bold_font = 1
set laststatus=2
set bg=dark
colorscheme hybrid_material

set mouse=a
set expandtab
set wrap
set linebreak
set syntax=auto
syntax on

autocmd BufWritePre * :%s/\s\+$//e

autocmd FileType python set ts=4
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType python match OverLength /\%79v.\+/
autocmd FileType python autocmd BufWritePre * :%s/\s\+$//e

nmap <F5> :NERDTreeToggle<CR> " f5 Nerdtree
nmap <F8> :TagbarToggle<CR> " f8 for tagbar
cabbrev bonly WSBufOnly
noremap <Tab> :WSNext<CR>
noremap <S-Tab> :WSPrev<CR>
noremap <Leader><Tab> :WSClose<CR>
noremap <Leader><S-Tab> :WSClose!<CR>
noremap <C-t> :WSTabNew<CR>
let g:workspace_powerline_separators = 1
let g:workspace_tab_icon = "\uf00a"
let g:workspace_left_trunc_icon = "\uf0a8"
let g:workspace_right_trunc_icon = "\uf0a9"

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "vimux"
let test#python#runner = 'pytest'

let g:ale_linters = {'python': ['flake8', 'pylint'],}

let g:localvimrc_ask = 0
EOF
    vim +BundleInstall +qa
}

[[ "bash" != $0  ]] && run
