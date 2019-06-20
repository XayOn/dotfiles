.. image:: http://i.imgur.com/VMIUygW.png

PrettierTerminal is an **all-in-one installer** :tophat: that configures
your terminal to be awesome

PrettierTerminal uses the amazing `ZPlug <https://github.com/zplug/zplug>`_ to
install almost all its features.

Current exceptions for this rule are:

- Zplug installation itself
- Automatic font installation and config
- NeoVim's plug.vim installation

.. contents:: :local:

.. image:: https://i.imgur.com/iuefY0f.gif


What does it offer
==================

General
--------
- **Awesomeness** :wink:
- Font-awesome based font (SauceCodePro)
- Pretty cool commands:
  + :sparkles: lsd :arrow_right: Enhanced ls with colors. Aliased to `ls` and `tree`
  + :sparkles: poetry :arrow_right: Python Dependency management and packaging. Integrated with zsh.
  + :sparkles: nvm :arrow_right: NodeJS Version Manager
  + :sparkles: bat :arrow_right: Enhanced cat with automatic syntax highlighting and paging
  + :sparkles: fd :arrow_right: Modern find replacement
  + :sparkles: fzf :arrow_right: Fuzzy finder. Configured with Ctrl+R keys.

NeoVim
------

Features:

- Good Python support (syntax highlighting, auto-completion)
- Git support
- Quake-like terminal (Open with F4)
- File browser with git support
- Pretty statusbars (lightline and tmuxline to match with tmux)
- Autoformatting for all languages
- Snippets
- Icons
- Nice startup page
- Ctrl+P-like search

Automatically installs the following plugins

- fugitive, gitgutter
- nuake
- vim-grepper
- denite
- nerdtree, nerdtree-git-plugin, vim-devicons
- vim-easy-align-tabs
- semshi, vdebug, deoplete, deoplete-jedi
- vim-snippets, ultisnips, neoformat
- vim-startify

Zsh
----
- Automatically calls ls upon cd'ing into a dir
- powerlevel10k with purepower
- Syntax highlighting
- Ctrl+Arrows to move between words

Tmux
----

- Style configured with vim's airline style



Usage
=====

Dependencies
------------

Basically everything is installed and contained in your $HOME. You only need to
have, preinstalled:

- neovim
- zsh
- git
- tmux

::

    apt-get install tmux neovim zsh vim

Installation
--------------

To install prettierTerminal, just **execute as your user install.bash**

NOTE: You can't execute the installer WITHIN tmux, as it will launch a TMUX as
part of the installation process
