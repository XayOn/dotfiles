

export PERL_LOCAL_LIB_ROOT="$HOME/.perl5";
export PERL_MB_OPT="--install_base $HOME/.perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5";
export PERL5LIB="$HOME/.perl5/lib/perl5/i486-linux-gnu-thread-multi-64int:$HOME/.perl5/lib/perl5";
export PATH="$HOME/.perl5/bin:$PATH";
mkdir -p $HOME/.perl5
cpan -j localinstall.cfg Term::ExtendedColor
cd src/ls--
perl Makefile.PL
make && su -c 'make install'
cp ls++.conf $HOME/.ls++.conf
