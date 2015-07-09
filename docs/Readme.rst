Prettier terminal
==================

This is a total rewrite of original prettierTerminal.
This has been done due to a few vim plugins starting to make everyone's life easier,
such as:

* *Vim-airline* -> Provides a cool powerline-like vim line.
* *promptline.vim*  -> Migrates that cool line to zsh, bash and fish.
* *tmuxline.vim*    -> The same for tmux.

So, yeah, this project is now vim-dependent =)

And, if you've got any problem with 

.. image:: http://media1.giphy.com/media/6idqG60e7D9e0/200w.gif

Here, I still manage a few more configurations. 
This way we end up having a cool all-with-the-same-appearance command line.
It also installs Inconsolata for powerline, a nice font patched for powerline.

Functionalities
===============

Tmux
----

* Loads tmuxline-generated config.
* Cmatrix screensaver
* Mouse support pre-configured


ZSH
---

* Loads promptline-generated config
* Oh-my-zsh preinstalled with:
  * syntax highglihgting

Bash
----

* Loads promptline-generated config
* Loads `Baex <http://github.com/XayOn/Baex>`_

Others
------

* Midnight Command solarized theme
* Mutt solarized theme

Installation
============

Currently, prettierTerminal depends on the following software:

* `spf13-vim <http://vim.spf13.com>` (or having vim-airline, promptline and tmuxline installed)
* tmux
* bash or zsh

And optionally, you could have:

* mutt
* mc

Now, just download this script and execute it.

::

    bash pt.bash

More info
=========

Have a look at the `Auto docs </docs/api.rst>`_
