all: conf

clean:
	rm -rf ~/.jabashit ~/.zshit ~/.tmuxshit

conf: clean
	@for i in */ ; do make -C $$i config; done

deps:
	make -C deps/

force: conf
	@bash .force_confs
	@make -C lifestyleshit  force # Force this motherfucking lifestyle
