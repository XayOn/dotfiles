.. image:: ./docs/logo.png

PrettierTerminal was an **all-in-one installer** :tophat: for your terminal to
become awesome. Now it's an pretty, consistent configuration for neovim, zsh
alacritty and sway.

.. contents:: :local:

Intro
-----

With time, CLI lovers have grown, and there are a lot of better
installers/solutions that do what prettierTerminal did, so I've kept the
awesomeness :sunglasses: of the configuration, with a lot less code by
leveraging on that same tools.

Arch :warning: It's been mostly tested on archlinux. Should work on any distro 

.. image:: ./docs/main.gif


Global installation
-------------------

For this script to work, as a pre-requisite on any system, you'll require, at
least:

- git
- curl
- python
- yay (on arch linux)

If you want my complete configuration, you need to install:

- `nwg-launchers <https://github.com/nwg-piotr/nwg-launchers>`_
- `alacritty <https://github.com/alacritty/alacritty/>`_
- `waybar <https://github.com/Alexays/Waybar/>`_
- `mpvpaper <https://github.com/GhostNaN/mpvpaper>`_ (optional)
- `Fira Code Font (patched by nerd fonts)
  <https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode>`_
- gtk-engine-murrine sassc optipng inkscape (gtk)

On archlinux, prettierTerminal will install them for you


You can install prettierTerminal with one single command:

.. code:: bash

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/XayOn/prettierTerminal/master/doc/install-full.sh)"

Or, the more traditional way 

.. code:: bash

  git clone https://github.com/XayOn/prettierTerminal
  cd prettierTerminal
  bash doc/install-full.sh

Note that this WILL NOT install the `firefox whitesur theme
<https://github.com/vinceliuice/WhiteSur-gtk-theme/tree/master/src/other/firefox>`_,
that's up to you.

NeoVIM configuration
--------------------

.. image:: docs/neovim.png

This is a kiss but fully featured neovim configuration, including:

- Firefox integration
- Tags and buffer bars
- Fuzzy finder
- Treesitter-based syntax highlighting
- Git management
- Show colors from your hex color codes
- Auto-detect tabs or spaces
- Database administration UIColor 
- Editorconfig support
- Custom galaxyline configuration based on spaceline.lua

NeoVim :warning: This requires a really recent version of `neovim
<https://neovim.io/>`_ nightly.

That's achieved with the following plugins:

+--------------------------------------------------------------------+---------------------------------------------------------+---------------------------------------------------------------+
| `vim-packager <https://github.com/kristijanhusak/vim-packager>`_   | `firenvim <https://github.com/glacambre/firenvim>`_     | `galaxyline <https://github.com/glepnir/galaxyline.nvim/>`_   |
+--------------------------------------------------------------------+---------------------------------------------------------+---------------------------------------------------------------+
| `barbar <https://github.com/romgrk/barbar.nvim>`_                  | `fzf <https://github.com/junegunn/fzf.vim>`_            | `fzf-preview <https://github.com/yuki-ycino/fzf-preview.vim>`_|
+--------------------------------------------------------------------+---------------------------------------------------------+---------------------------------------------------------------+
| `treesitter <https://github.com/nvim-treesitter/nvim-treesitter>`_ | `tender <https://github.com/jacoborus/tender.vim>`_     | `gina <https://github.com/lambdalisue/gina.vim>`_             |
+--------------------------------------------------------------------+---------------------------------------------------------+---------------------------------------------------------------+
| `signify <https://github.com/mhinz/vim-signify>`_                  |                                                         | `sleuth <https://github.com/tpope/vim-sleuth>`_               |
+--------------------------------------------------------------------+---------------------------------------------------------+---------------------------------------------------------------+
| `editorconfig <https://github.com/editorconfig/editorconfig-vim>`_ | `dadbod-ui <https://github.com/tpope/vim-dadbod>`_      | `dap <https://github.com/mfussenegger/nvim-dap-python>`_      |
+--------------------------------------------------------------------+---------------------------------------------------------+---------------------------------------------------------------+

Dependencies
____________

To use python debugger (dap) you'll need to have python3, and to install coc,
you'll need to have nodejs. 
On archlinux, prettierTerminal will install them for you

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


Dependencies
_____________

Requires lsd and zsh to be installed.
On archlinux, prettierTerminal will install them for you

SwayWM configuration
---------------------

`Sway window manager <https://swaywm.org/>`_ is a tiling Wayland compositor and
a drop-in replacement for i3. 

On these screenshots I use `WhiteSur dark theme for GTK and firefox
<https://github.com/vinceliuice/WhiteSur-gtk-theme>`_ with
`mpvpaper <https://github.com/GhostNaN/mpvpaper>`_ for the animated
backgrounds.

Dependencies
____________

To use this swaywm configuration, you'd need:

- `nwg-launchers <https://github.com/nwg-piotr/nwg-launchers>`_
- `alacritty <https://github.com/alacritty/alacritty/>`_
- `waybar <https://github.com/Alexays/Waybar/>`_
- `mpvpaper <https://github.com/GhostNaN/mpvpaper>`_ (optional)

On archlinux, prettierTerminal will install them for you
