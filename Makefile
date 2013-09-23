all: conf

clean:
	rm -rf ~/.bash ~/.zsh ~/.tmux

conf: clean
	@for i in */ ; do make -C $$i config; done

deps:
	make -C deps/
	cd ..

force: conf
	@bash .force_confs
