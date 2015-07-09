CONFIG="default"

default: all

all: clean
	mkdir build
	cat baex.bash pt.bash > build/pt.bash

clean:
	rm -rf build

recreate_docs: all
	bash -c "source build/pt.bash; show_docs > ../docs/api.rst"
