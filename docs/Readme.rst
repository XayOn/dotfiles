Prettier terminal
==================

This is a total rewrite of original prettierTerminal.
This has been done due to a few vim plugins starting to make everyone's life easier,
such as:

* *Vim-airline* -> Provides a cool powerline-like vim line.
* *promptline.vim*  -> Migrates that cool line to zsh, bash and fish.
* *tmuxline.vim*    -> The same for tmux.

So, yeah, this project is now vim-dependent =)

And, if you've got any problem with vim...

.. image:: http://media1.giphy.com/media/6idqG60e7D9e0/200w.gif

Here, I still manage a few more configurations. 
This way we end up having a cool all-with-the-same-appearance command line.
It also installs Inconsolata for powerline, a nice font patched for powerline.

This requires VIM and xfce4-terminal, and optionally tmux, bash and zsh.

I'd recommend the xfce4-terminal + tmux + zsh setup =)
On debian systems, you could do:

::

    apt-get install tmux xfce4-terminal zsh vim bash


.. image:: /docs/start.gif

Functionalities
===============

VIM
---

* Installs SPF13-VIM

SOLARIZED
---------

Adds solarized support to:

* Tmux
* LS_COLORS
* VIM
* xfce4-terminal

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
