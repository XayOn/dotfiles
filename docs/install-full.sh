# Auto-installation script 

# Setup zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
curl -fLo  ~/.zshrc.pt --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/zshrc
echo "source ~/.zshrc.pt" >> ~/.zshrc
zsh -c exit

# Install NeoVim
git clone https://github.com/kristijanhusak/vim-packager ~/.config/nvim/pack/packager/opt/vim-packager
curl -fLo ~/.local/share/nvim/init.vim --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/neovim
nvim +PackagerInstall +q

# Setup swaywm
curl -fLo ~/.config/sway/config --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/swaywm
