ConsoleShit
============

This is an organished set of configurations for bash, tmux, zsh and some 
other shit. 

It helps mantaining the consistency of styles in your terminal (uses 
powerline and solarized as main styles) and splits it up in different 
directories.

.. image:: https://raw.github.com/XayOn/consoleshit/master/consoleshit.png

tmuxshit:
 - Configuration for tmux including:
   Tmux-powerline
   Tmux-solarized
   Cmatrix screensaver for tmux conf
   Mouse support enabled by default

Jabashit:
 - Huge set of confs for bash, including also powerline and LS_COLORS

Zshit:
 - Small set of confs for bash, relying on oh-my-zsh (it installs this 
   also), with powerline-zsh theme combined with the zsh fork of 
   bash-powerline for theme consistency.

Othershit
 - Interesting configuration for other tools, right now it contains mutt and 
   mc's solarized themes.
 - CW color wrappers from fakehalo
 - ls++ from trapd00r
   - This requires perl module Term::ExtendedColor, so I'm not replacing ls 
     for ls++ by default

ls++
+++++++

For some reason ls++ install is asking for root permissions, till I firgure 
it out, I leave it outside default installation, if you want to install it, 
just execute:

::

    make -C consoleshit ls--

To use ls++ by default instead of ls, write this down on your .bashrc or 
your .zshrc:

::

    alias ls=ls++


Notes
========

Most of the work here is not mine, I just made it easy to install and put it 
all togheter.
Novice users probably lose a lot of interest in the console because its 
default "ugliness" and/or difficulty to install themes, this makes it all 
easier, getting the nicest themes and works available out there for bash.

Each external package (tmux-solarized, tmux-powerline, oh-my-zsh, 
zsh-powerline, oh-my-zsh-themes-powerline, mc-colors-solarized, 
mutt-colors-solarized, bash-powerline, LS_COLORS... ) are included in this 
repo as submodules.

Installation
============

First, you have to download every submodules (recursive way):

::

    git submodule init;
    git submodule update;
    git submodule foreach git submodule init ;
    git submodule update --recursive

If you want it to keep your conf files as they are, allowing you to manually 
include this confs in each of them execute:

::

    make

If you want it to "just work", enabling everything by default:

::

    make force


If you're too lazy, you always could do:

::

    wget --no-check-certificate \
    https://github.com/XayOn/consoleshit/raw/master/install.sh -O \
    - | sh


Here you have a consoleshit installation tutorial with a demo: 
http://www.youtube.com/watch?v=FEK1hPHtmw8

