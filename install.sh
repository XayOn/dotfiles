tmp=$(mktemp -d);
cd $tmp;
git clone http://github.com/XayOn/consoleshit
cd consoleshit
git submodule foreach git submodule init ;
git submodule update --recursive
make force
cd

