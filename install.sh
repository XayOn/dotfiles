# Pre-requisites, zsh, tmux and neovim plugin managers.
#
# Install zsh plugin manager 
{ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; } &>/dev/null
curl -fLo  ~/.zshrc --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/zshrc
zsh -c exit

# Install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl -fLo ~/.tmux.conf --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/tmux
~/.tmux/plugins/tpm/bin/install_plugins

# Install NeoVim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/init.vim --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/neovim
nvim +PlugInstall +qa
