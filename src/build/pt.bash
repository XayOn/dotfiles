#!/bin/bash
declare -A colors highlights theme
theme=([menu_number]=231 [normal]=90 [separator]='-' [menu_separator]="|"  [menu_separator_color]=40 [menu_edge]="+" )
highlights=([standout]=0 [underline]=1 [reverse]=2 [blink]=3 [dim]=4 [bold]=5 [invis]=6 [protect]=7 [altcharset]=8 )
colors=( [none]=0 [black]=1 [blue]=2 [green]=3 [cyan]=4 [magenta]=5 [yellow]=6 [white]=7 )
doc(){
    # This enables python-style docstrings for functions
    [[ $PRINT_DOCS == 1 ]] && {
        cat /dev/stdin 2>/dev/null
        return 1;
    }
}

endoc=""

show_docs(){
    # print all docs
    declare -F | while read _ _ function; do 
        [[ $function == "doc" ]] && continue
        [[ $function == "show_docs" ]] && continue
        PRINT_DOCS=1 endoc="return 0" $function | sed 's/^    //'
        echo
    done
}

require(){
doc <<EOD

    require 
    -------

    :param list of libraries: List of libraries to load

    Sources files on list_of_libraries.
    Those files MUST be on current_path and have .bash extension

    As I'm migrating this to a single-script (compiled) this will probably
    not be needed anymore.

EOD

eval $endoc

    for lib in ${@}; do source ${lib}.bash; done

}

_(){
doc <<EOD

    "_"
    -----

    Translate a string

    This is an alias of gettext "\$@"

EOD

eval $endoc

    gettext "$@"

}
#!/bin/bash

longest_element(){
doc <<EOD

    longest_elemen_len
    ------------------

    Given an array of strings, gets the longest element in them.

    :param array: Array of strings to get the longest element
    :returns: Longest element

EOD

eval $endoc

    { # Make it silent.

        current=""
        for elem in "${@}"; do
            (( ${#elem} > ${#current} )) && current=${elem}
        done

    } &>/dev/null

    echo -n $current
}


arithmetic_avg(){

doc <<EOD

    arithmetic_avg
    -------------------

    Gets the arithmetic average

EOD

eval $endoc

    echo $(( ( $1 - $2 ) / 2 ))

}

split(){

doc <<EOD
    
    split
    -----

    split a string using a specified separator

    :param string: String to split
    :param separator: Separator
    :param return: Where to store return array

EOD

eval $endoc

    declare -ax $3
    declare -n RESULT=$3

    RESULT=( $(echo $1|tr $2 " ") )

}

make_associative(){
doc <<EOD

    make_associative 
    ----------------

    :param variable_to_store_results: Where to store result

    Exports a global variable <variable_to_store_results> containing
    an associative array from the text provided via stdin

    This expects two-column input as:

    ::

        foo bar
        baz stuff
        baz stuff stuff

EOD

eval $endoc


    declare -Axg $1
    declare -n RESULT=$1

    while read name value; do
        RESULT[$name]="${value}"
    done </dev/stdin
}
#!/bin/bash
# Screen Utilities
auto_termsize(){
doc <<EOD

    auto_termsize
    -------------

    Adds a trap on "winch" signal, so columns and lines global variables 
    (COLUMNS, LINES) are updated in real time


EOD
    export COLUMNS=$(tput cols)
    export LINES=$(tput lines)
    trap 'export COLUMNS=$(tput cols) export LINES=$(tput lines)' WINCH
}

screen_goto(){ 
doc <<EOD

    screen_goto
    -----------

    Put the cursor in a specific position in the screen.

    :param cols: Column to put it into
    :param rows: Row to put it into


EOD
eval $endoc

    tput cup $1 $2
}

echo_at(){
doc <<EOD

    echo_at
    --------

    Echo into a specific location.

    :param X: X position 
    :param Y: Y position 
    :param text: This behaves just like echo. It'll accept any parameter there.

EOD

    screen_goto $1 $2
    shift 2
    echo $@
} 

echo_center(){

doc <<EOD

    echo_center
    -----------

    Center text.

    :param text: Just like echo.

EOD
eval $endoc

    # We force the screen trap.
    auto_termsize

    # Get current row
    get_current_position pos

    echo_at  ${pos[0]} $(arithmetic_avg  $COLUMNS  ${#1}) ${@}
}

get_current_position(){
doc <<EOD

    get_current_position
    --------------------

    Gets current position (X,Y) of the cursor on the screen.

    :params result: Variable to store the result into.

EOD

eval $endoc

    declare -axg $1 pos
    declare -n res=$1

    echo -en "\033[6n"; IFS=";" read -s -r -d R -a pos
    res=($((${pos[0]:2} - 1)) $((${pos[1]} - 1)))
}


repeat_char(){
doc <<EOD

    repeat_char
    -----------

    Repeats a character N times. No newline added.

    :param char: Character to repeat
    :param times: Times to repeat it

EOD

eval $endoc

    eval printf "$1%.0s" {1..$2}
}

mkline(){
doc <<EOD

    mkline
    ------

    Creates a line with the given character.

    :param char: character

EOD

eval $endoc

    repeat_char "$1" $(($COLUMNS - 3)) 
}

mkemptyline(){
doc <<EOD

    mkemptyline
    -----------

    Creates a hollow line with the given character as delimitier by both sides

    :param char: character

EOD

eval $endoc
    echo -en $1
    repeat_char "\" \"" $(($COLUMNS - 3)) 
    echo -en $1

    #get_current_position current_pos
    #screen_goto $(( ${current_pos[0]} - 1 )) 0
}

reset_row(){
doc << EOD

    reset_row
    ---------

    Puts cursor on col 0

EOD

eval $endoc

    tput cub $COLUMNS
    tput cuf 2

}

wrap(){
doc <<EOD

    wrap
    ----

    Simply wraps an string with a start and an end.

    :param start: start string
    :param content: content string
    :param end: end string

EOD

eval $endoc

    echo -en $1
    echo -en $2
    echo -e  $3

}
titled_box(){
doc <<EOD

    titled_box
    ----------

    Creates a cool utf-8 box with enumerated options.
    Does not print text options nor do anything to choose.
    
    .. note::

        Caveat: only 1 line options supported... 
        and that depends on line size =(

    :param title: Title
    :param number_of_options: Number of options to create the box fo.

EOD

eval $endoc

    # We force the size trap
    auto_termsize

    wrap  "┌" "$(mkline ─)" "┐"

    mkemptyline "│"
    reset_row
    echo_center $1

    declare -xag menu_start menu_end
    get_current_position menu_start

    for n in $(seq 1 $2); do
        mkemptyline "│" 
        reset_row
        echo " $n │ "
    done

    get_current_position menu_end

    wrap  "└" "$(mkline ─)" "┘"
}

fill_titled_box(){
doc <<EOD

    fill_titled_box
    ---------------

    Fills a previously (the latest, in fact...) created box.

    .. note::

        This is kinda not-nice. Be careful.
        Also, as titled_box, supports only one line options depending
        on line-size.

    .. note::

        TODO: I could allow to pass menu_start and menu_end values
        as an option. This way I could fill previously created menus
        and make multi-menu windows =)
EOD

eval $endoc

    # We force the size trap
    auto_termsize

    opts=("${@}");

    for opt in ${!opts[@]}; do
        screen_goto $((${menu_start[0]} + ${opt} )) $((${menu_start[1]} + 7))
        echo ${opts[$opt]}
    done

    screen_goto ${menu_end}
}

simple_menu(){
doc <<EOD

    simple_menu
    -----------

    Creates a simple menu
    :param title: Title
    :param store: Where to store user choice
    :params options: Options (all the rest of the parameters
EOD

eval $endoc

    title=$1
    storage=$2
    shift 2
    declare -n RESULT=$storage

    opts=("${@}");
    titled_box $title "${#opts[@]}"
    fill_titled_box "${opts[@]}"
    echo

    read -p "Enter option: " RESULT
}
get_color(){
doc <<EOD

    get_color
    ---------

    :param color: Color to return

    Returns either a color (just a normal echo) or a stablished color
    from the theme's palette.

    This is probably not very useful, and might be changed in a near future

EOD

eval $endoc

    [[ $1 < 254 ]] && {
        echo $1
    } || {
        echo ${colors[$1]}
    }

}

set_foreground(){
doc <<EOD

    set_foreground
    --------------

    Sets the current fg color.

    :param color: 0-255 or long name specified in colors variable

EOD

eval $endoc

    color=$(get_color ${1})
    [[ $color ]] && tput setaf $color
}

set_background(){
doc <<EOD

    set_background
    --------------

    Sets the current bg color.

    :param color: 0-255 or long name specified in colors variable

EOD

eval $endoc

    color=$(get_color ${1})
    [[ $color ]] && tput setbg $color
}

colorize(){

doc <<EOD

    colorize
    --------

    Colorizes a phrase.

    :param fg: Foreground color
    :param bg: Background color
    :param phrase: what to apply color on. This takes ${@} - $1 - $2 (2:)

    fg and bg are a number between 0-255 or the long name specified in the
    colors variable (stablished in the current theme).


EOD

eval $endoc

    set_foreground $1; shift
    set_background $2; shift

    echo -en "${@}"
    tput sgr0
}
#!/bin/bash

handle_optical(){

doc <<EOD

    handle_optical
    --------------

    Executes common actions on cd/dvd images.

    Actually available actions:

    * save_disk: Copies the content of a cd/dvd to an iso image
    * write_iso: Writes an ISO image to a cd/dvd
    * write_dir: Creates an ISO image and writes it into a cd/dvd
    * erase_dev: Cleans a rw cd/dvd.

    :param action: Action to execute
    :param device: Device to execute actions on
    :param file: File/Source/Destiny folder to execute actions on

EOD

eval $endoc

    action=$1; shift
    cd_${action} ${@}
}

cd_erase_disk(){
doc <<EOD

    cd_erase_disk
    -------------

    Erases the content of a rw drive

    :param drive: cd/dvd drive

EOD

eval $endoc

    wodim blank=fast -eject dev=$1; 
}

cd_write_dir(){
doc <<EOD

    cd_write_dir
    ------------

    Creates an ISO image from a directory and then 
    writes it into a cd/dvd

    :param drive: cd/dvd drive
    :param dir: directory to write on the cd/dvd

EOD

eval $endoc

    temp=$(mktemp)
    mkisofs -o ${temp}.iso -J -r -v $2 
    cdtool "write_iso" $1 ${temp}.iso 
    rm ${temp}.iso

}

cd_write_iso(){
doc <<EOD

    cd_write_iso
    ------------

    Writes an ISO image to a cd/dvd drive

    :param drive: cd/dvd drive
    :param file: File to write cd/dvd image from

EOD

eval $endoc

    {
        wodim -eject -tao speed=1 dev=$1 -v -data $2
    } || {
        wodim -eject -tao speed=1 dev=$1 -v -data $2
    }
}

cd_save_disk(){
doc <<EOD

    cd_save_disk
    ------------

    Saves a cd/dvd to disk

    :param drive: cd/dvd drive
    :param file: destination file

EOD

eval $endoc

    dd if=$1 of=$2 bs=2048 conv=sync,notrunc; 
}
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
