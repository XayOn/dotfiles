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
echo "Writing log in ${LOG}"

run_and_log(){
    #$2 &> ${LOG} && {
    $2 && {
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

run_and_log "Instalando spf13-vim" spf13vim
run_and_log "Get vim promptline and tmuxline" get_vim_lines
run_and_log "Get dircolors" get_dircolors
run_and_log "Get inconsolata" get_inconsolata_for_powerline
run_and_log "Make zsh config" zsh
run_and_log "Make bash config" install_bash
run_and_log "Make tmux config" tmux
run_and_log "Get xresources" xresources
run_and_log "Configure xfce4 terminal" xfce4_terminal
