config:
	@export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin; cd src/cw-*/; /bin/bash configure; make  installlocal ; cd ../..
	@mkdir -p ~/.config/mc ~/.irssi ~/.mutt ~/.consoleshit
	@bash install_ls++.sh
	@cat src/mc-solarized-skin/solarized.ini >> ~/.config/mc/ini
	@cp src/irssi-colors-solarized/solarized-universal.theme ~/.irssi/
	@cp src/mutt-colors-solarized/mutt-colors-solarized-light-256.muttrc ~/.mutt/
	@echo "Now source ~/mutt-colors-solarized-light-256.muttr on your .muttrc"
	@cp src/confs/zshrc ~/.consoleshit/
	@cp src/confs/bashrc ~/.consoleshit/
	@echo "Now source ~/.consoleshit/zshrc or ~/.consoleshit/bashrc on your .zshrc or your .bashrc"

force:
	@echo "source ~/.consoleshit/zshrc" >> ~/.zshrc
	@echo "source ~/.consoleshit/bashrc" >> ~/.bashrc

