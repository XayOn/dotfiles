get_dircolors
-------------

Downloads dircolors-solarized.


get_inconsolata_for_powerline
-----------------------------

- Adds inconsolata for powerline to ~/.fonts


get_vim_lines
-------------

Executes vim promptline and tmuxline plugins to get the configs.


install_bash
------------

This code actually:

* Creates a bashrc.pt with vim-promptline sourcing on it
* If not already on ~/.bashrc, adds a line sourcing it


run main stuff
--------------

Runs the script


[32m✓[0m 


spf13vim
--------

Installs spf13-vim.


tmux
-----

* Creates a tmux config file.
* If not already on ~/.tmuxrc source it.


xfce4_terminal
--------------

- Downloads solarized config for xfce4 temrminal and applies it.
- Configures Inconsolata for Powerline

.. warning::

    BE CAREFUL.
    This COMPLETLY overwrites your xfce4-terminal configuration.


xresources
----------

Downloads xresources solarized file, puts it into ~/.Xresources 
(not overwriting) and reloads xresources

.. warning::

    This APPENDS to ~/.Xresources, so you might have to clean it
    manually if something goes wrong


zsh
-----

* Install (via curl) oh-my-zsh
* Enables git plugin
* Creates a zshrc.pt with vim-promptline sourcing on it
* If not already on ~/.zshrc, adds a line sourcing it
