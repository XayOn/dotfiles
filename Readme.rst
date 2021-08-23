Pretty, consistent configuration for neovim, zsh alacritty and bspwm.

Features
--------

- Four workspaces. No need for more 👍
- Minimalistic config files. Not overriding defaults or copying example files
  whenever possible
- Mostly distraction-free. Minimal info in the bar
- Terminal-centric, keyboard-centric

- `Material <https://material-theme.site/>`_ based colors almost everywhere. 
  OC alacritty (partial) port, polybar, bspwm and rofi.
  Wherever not possible, "dark material" colours are used (materia-dark for
  gtk, altough no GTK app is being shown)

- Modern NeoVIM config with all the new stuff (treesitter, dap, lsp...)
  - Custom which-key menu
  - Mostly python-oriented configurations
  - Lua configuration from scratch
- ZSH configuration with the same filosophy

Wallpaper on screenshots (you'll need to place it on .wallpaper.png on your
home) is from `Wallpapercave <https://wallpapercave.com/minimal-nature-wallpapers#>`_

Works well with `my moonlander configuration <https://configure.zsa.io/moonlander/layouts/xMmq0/latest/0>`_

.. contents:: :local:

Screenshots
------------

There's no better way to show a rice than screenshots. 
Here goes clean, neovim and tmux:

.. image:: ./docs/clean.png

.. image:: ./docs/neovim.png

.. image:: ./docs/rofi.png

.. image:: ./docs/tmux_ncmpcpp.png

.. image:: ./docs/dunst.png


Mandatory gif too:

.. image:: ./docs/main.gif


Global installation
-------------------

Tested on:

 - Debian testing
 - Ubuntu 20.04
 - ArchLinux

Uses DotBot to install, should work on any system with:

- git
- curl
- python
- yay or apt

You can install prettierTerminal with one single command:

.. code:: bash

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/XayOn/prettierTerminal/master/install-remote.sh)"

Or, the more traditional way 

.. code:: bash

  git clone https://github.com/XayOn/prettierTerminal
  cd prettierTerminal
  bash install.sh


Manual dependencies installation

- neovim nightly
- `alacritty <https://github.com/alacritty/alacritty/>`
- `Fira Code Font (patched by nerd fonts) <https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode>`_
- lazygit, node, pyright, lsd, zsh
- Materia gtk theme https://github.com/nana-4/materia-theme


NeoVIM configuration
--------------------

.. image:: docs/neovim.png

This is a kiss but fully featured neovim configuration, with IDE-like features
preconfigured, mainly for python development

- Lots of UI goodies. Makes the experience a tad similar to modern IDEs,
  without most of the crappy parts.
- Wichkey with preconfigured menus
- Git management with lazygit
- Database administration UI
- The trinity of modern neovim configs:
    - Treesitter-based syntax highlighting
    - Debugger with DAP
    - LSP (requires pyright to be installed for python)

:warning: This requires a really recent version of `neovim <https://neovim.io/>`_ nightly.

Press leader (,) to see a nice menu with the leader-prefixed keybindings.
Default vim keybindings will work as usuarl

Dependencies
____________

Neovim-nightly is required, with:

- python3 
- pip
- nodejs
- pyright (pip install pyright)
- lazygit (you'll have to manually install this one)


ZSH Configuration
-----------------

For ZSH, it installs `ZINIT <https://github.com/zdharma/zinit>`_, my
currently-favourite zsh plugin manager.

It will install a few plugins, the `pure
<https://github.com/sindresorhus/pure>`_ zsh theme, and the following binaries:

  - `bat` - Enhanced cat with automatic syntax highlighting and paging
  - `fzf <https://github.com/junegunn/fzf/>` Fuzzy finder. Configured with
    Ctrl+R keys.

The plugins currently installed are:

- `zsh-users/zsh-autosuggestions
  <https://github.com/zsh-users/zsh-autosuggestions>`_
- `zdharma/fast-syntax-highlighting
  <https://github.com/zdharma/fast-syntax-highlighting>`_
- `desyncr/auto-ls <https://github.com/desyncr/auto-ls>`_
- `MichaelAquilina/zsh-auto-notify
  <https://github.com/MichaelAquilina/zsh-auto-notify>`_
- `junegunn/fzf <https://github.com/junegunn/fzf>`_
- `LS_COLORS <https://github.com/trapdoor/LS_COLORS>`_

BSPWM configuration
---------------------

BSPWM is a lightweight tiling window manager

.. image:: ./docs/clean.png

Keybindings are defined in sxhkdrc

Dependencies
_____________

To use this bspwm configuration, you'd need:

- bspwm
- rofi
- sxhkd
- polybar
- i3lock-fancy
- materia-gtk-theme


The hardware
-------------

If you have a moonlander ⌨️, I'm using some features (tap dance, layers...) to
use bspwm without having to press two keys at the same time. Pretty much like
vim's leader key. I've linked my moonlander configuration on the repository

Extra
-----

I'm using mautrix-* + gomuks as my main communications platform, khal to manage
my nextcloud calendars, and neovim with neorg for my todo lists, wich covers
all my basic needs.

Works well with less than 1gb ram (if you don't use firefox/chrome, that is)
