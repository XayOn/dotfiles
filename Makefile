all: conf

clean:
	rm -rf ~/.jabashit ~/.zshit ~/.tmuxshit

conf:
	@for i in */ ; do make -C $$i config; done

force: conf
	@bash .force_confs
