
I have an alias `rebuild` just call it with the reproducible.dsc

## From the wiki: https://wiki.debian.org/ReproducibleBuilds/Howto#Testing_procedure

The easiest way to get a test environment for now is to use pbuilder. Setup a build chroot with the experimental toolchain. Then clone the reproducible/misc.git repository.

Hacking packages then looks like:

    apt-get source foo

    cd foo*

    dch -v "$(dpkg-parsechangelog -S Version).0~reproducible1"
    Fix reproducibility issues.

    dpkg-buildpackage -S

    cd ../../misc/prebuilder

    dcmd cp ../foo*reproducible1*.dsc .

    ./rebuild.sh foo 

Look for a fat big “reproducible” banner if test is successful. Otherwise, look for logs and debbindiff output in the logs directory. 

