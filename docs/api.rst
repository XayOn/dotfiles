get_vim_lines
-------------

Executes vim promptline and tmuxline plugins to get the configs.


bash
-----

This code actually:

* Creates a bashrc.pt with vim-promptline sourcing on it
* If not already on ~/.bashrc, adds a line sourcing it

TODO: Do this =)



try_spf13
---------

tries to install required plugins using spf13-vim

zsh
-----

* Install (via curl) oh-my-zsh
* Enables git plugin
* Creates a zshrc.pt with vim-promptline sourcing on it
* If not already on ~/.zshrc, adds a line sourcing it
