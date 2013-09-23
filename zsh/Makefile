all:config

config:
	@install -d /home/$(USER)/.prettierTerminal/zsh
	@cp -r src/* /home/$(USER)/.prettierTerminal/zsh/
	@ln -s /home/$(USER)/.prettierTerminal/zsh/oh-my-zsh-powerline-theme/powerline.zsh-theme /home/$(USER)/.zshit/oh-my-zsh/themes/
	@mkdir -p /home/$(USER)/.prettierTerminal/zsh/oh-my-zsh/custom/plugins
	@ln -s /home/$(USER)/.prettierTerminal/zsh/zsh-syntax-highlighting /home/$(USER)/.zshit/oh-my-zsh/custom/plugins/
	@ln -s /home/$(USER)/.prettierTerminal/zsh/zsh-syntax-highlighting-filetypes /home/$(USER)/.zshit/oh-my-zsh/custom/plugins/
	@echo "Now just put 'source /home/$(USER)/.prettierTerminal/zsh/confs/zshrc' on your .zshrc"
