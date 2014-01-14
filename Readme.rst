Prettier terminal
==================

This is an organished set of configurations for tmux, zsh and some
other cli or tui apps.

It helps mantaining the consistency of styles in your terminal (uses
powerline and solarized as main styles) and splits it up in different
directories.

.. image:: https://raw.github.com/XayOn/prettierTerminal/master/prettierTerminal.png


This installs Inconsolata for powerline, a nice font patched for powerline.

You need to have python PIP installed, in debian and ubuntu:

::

    apt-get install python-pip

tmux:
 - Configuration for tmux including:
   Powerline
   Solarized
   Cmatrix screensaver for tmux conf
   Mouse support enabled by default

Zsh:
 - Small set of confs for zsh, relying on oh-my-zsh (it installs this
   also), with powerline theme and zsh syntax highlighting.

Others:
 - Interesting configuration for other tools, right now it contains mutt and
   mc's solarized themes.
 - ls++ from trapd00r
   - This requires perl module Term::ExtendedColor, so I'm not replacing ls for ls++ by default

ls++
+++++++

To use ls++ by default instead of ls, write this down on your .bashrc or
your .zshrc:

::

    alias ls=ls++


For that, you have to install Term::ExtendedColor, I recomend installing it
systemwide:

::

    su -c "cpan Term::ExtendedColor"


Notes
========

Most of the work here is not mine, I just made it easy to install and put it
all togheter.

Novice users probably lose a lot of interest in the console because its
default "ugliness" and/or difficulty to install themes, this makes it all
easier, getting the nicest themes and works available out there for bash.

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

After that, you have to look at .prettierTerminal and include in your configuration file the bashrc/zshrc/foorc files.

If you want it to "just work", enabling everything by default:

::

    make force


If you're too lazy, you always could do:

::

    wget --no-check-certificate \
    https://github.com/XayOn/prettierTerminal/raw/master/install.sh -O \
    - | sh


Here you have an installation tutorial with a demo:
http://www.youtube.com/watch?v=FEK1hPHtmw8

