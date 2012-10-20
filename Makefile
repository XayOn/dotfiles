all: conf

conf:
	@for i in */ ; do make -C $$i config; done

force: conf
	@bash .force_confs
