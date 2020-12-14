# Setup zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
curl -fLo  ~/.zshrc.pt --create-dirs https://raw.githubusercontent.com/XayOn/prettierTerminal/master/zshrc
echo "source ~/.zshrc.pt" >> ~/.zshrc
zsh
