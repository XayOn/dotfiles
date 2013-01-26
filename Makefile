all: conf

clean:
	rm -rf ~/.jabashit ~/.zshit ~/.tmuxshit

conf: clean
	@for i in */ ; do make -C $$i config; done

deps:
	make -C deps/
	cd ..

force: conf
	@bash .force_confs
