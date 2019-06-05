# The only system-wide pre-requisites are: git, neovim, zsh

# Install ZPLUG
{ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; } &>/dev/null

# Install Neovim
mkdir -p ~/.config/nvim/
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
grep pt.vim ~/.config/nvim/init.vim &>/dev/null || { echo -e '\nsource ~/.zplug/repos/XayOn/c64b066d69734f6d0f5cbf2236d21bd5/pt.vim' >> ~/.config/nvim/init.vim; }

# Install and configure fonts as default system font
mkdir -p ~/.local/share/fonts/; mkdir -p ~/.config/fontconfig/; 
curl -L --output ~/.local/share/fonts/SauceCodePro\ Nerd\ Font\ Mono.ttf "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf?raw=true"

cat << EOF >~/.config/fontconfig/fonts.conf
<match target="pattern">
  <test name="family" qual="any">
   <string>monospace</string>
  </test>
  <edit binding="strong" mode="prepend" name="family">
   <string>SauceCodePro Nerd Font Mono</string>
  </edit>
 </match>
EOF

fc-cache -f ~/.local/share/fonts

# Setup zplug, neovim and required tools
cat << EOF >~/.zshrc.pt
source ~/.zplug/init.zsh

# Use enhancd
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_DOT_SHOW_FULLPATH=1

# Use "lsd" as default ls command
# Default to long and human display options and dont print newline
zplug "Peltoche/lsd", from:gh-r, as:command

# Install POETRY, python management tool
zplug "sdispater/poetry", from:github, as:command, hook-build:"python get-poetry.py"

# Zsh plugin for poetry. Fixes some issues and auto-loads poetry envs
zplug 'darvid/zsh-poetry', from:github 

# Install node version manager and nodejs
zplug 'lukechilds/zsh-nvm'

# Install bat, a cat alternative 
# TODO: bat seems to not install correct arch on linux. 
# This forces it to x86_64 linux so it wont work on mac or windows.
# (nor arm or x86)
zplug 'sharkdp/bat', as:command, from:gh-r, rename-to:bat, use:"*x86_64-*-linux*"

# Intuitive and fast "find" replacement 
zplug 'sharkdp/fd', as:command, from:gh-r

# Install FZF, a fuzzy finder
# Ctrl+r will use fzf now to search on history among other things.
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug 'junegunn/fzf', use:'shell/key-bindings.zsh'

# Automatically ls upon entering a dir.
zplug "desyncr/auto-ls", from:github
alias ls="lsd -lh"
alias tree="lsd --tree"
AUTO_LS_NEWLINE=false
AUTO_LS_COMMANDS=(ls)

# Setup theme, powerlevel10k wich is quite faster than 9k
zplug 'romkatv/powerlevel10k', use:powerlevel10k.zsh-theme

# Setup neovim
zplug "XayOn/c64b066d69734f6d0f5cbf2236d21bd5", from:gist, hook-build: "pip install --user yapf docformatter; nvim +PlugInstall +UpdateRemotePlugins +qa; tmux new vim +Tmuxline +TmuxlineSnapshot\ ~/.tmux.pt.conf +qa"
# Manage Zplug with zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Zsh syntax highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
zplug check || zplug install

# Then, source plugins and add commands to \$PATH
zplug load

alias cat=bat --paging=never

source ~/.purepower
export PATH=$PATH:~/.local/bin

EOF

grep ".zshrc.pt" ~/.zshrc &>/dev/null || { echo -e "\nsource ~/.zshrc.pt" >> ~/.zshrc;  }
( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

grep "tmux.pt.conf" ~/.tmux.conf || { echo -e "\nsource ~/.tmux.pt.conf\n" >> ~/.tmux.conf; }

zsh
