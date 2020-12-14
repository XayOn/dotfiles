# Auto-installation script 

# Setup zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
curl -fLo  ~/.zshrc --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/zshrc
zsh -c exit

# Install NeoVim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/init.vim --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/neovim
nvim +PlugInstall +qa
