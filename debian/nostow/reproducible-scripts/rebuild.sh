#!/bin/sh

BASEPATH="/var/cache/pbuilder/base-reproducible.tgz"
USE_COWBUILDER=
SCRIPT_DIR="$(dirname "$0")"

while getopts b:c o; do
	case $o in
	b )	BASEPATH="$OPTARG"
		[ "${BASEPATH%.cow}" != "${BASEPATH}" ] && USE_COWBUILDER=true
		;;
	c )	USE_COWBUILDER=true;;
	esac
done
shift "$(expr $OPTIND - 1)"

if [ -n "$USE_COWBUILDER" ]; then
	BUILDER=cowbuilder
	BUILDER_OPTS="--basepath $BASEPATH"
else
	BUILDER=pbuilder
	BUILDER_OPTS="--basetgz $BASEPATH"
fi

if [ $# -eq 0 ]; then
    echo "usage: $0 [-b basepath] [-c] package_name"
    exit 1
fi

PACKAGE="$1"

rm -r b1 b2
mkdir -p b1 b2 logs

sudo -E \
 DEB_BUILD_OPTIONS="nocheck" \
 TZ="/usr/share/zoneinfo/Etc/GMT+12" \
 unshare --uts -- $BUILDER --build $BUILDER_OPTS \
    --debbuildopts '-b' \
    --buildresult b1 \
    --logfile logs/${PACKAGE}.build1 \
    ${PACKAGE}_*.dsc
xz < logs/${PACKAGE}.build1 > logs/${PACKAGE}.build1.xz
rm -f logs/${PACKAGE}.build1

# Let's make a tarball of the build result. This allows us
# to give it to the second run of pbuilder. The configured
# hook will then run debbindiff at the end of the second
# build.

TMPDIR=$(mktemp -d) || exit 1
trap "rm -rf '$TMPDIR'" EXIT
TMPTAR="$TMPDIR/initial_build.tar"

(cd b1 && tar -cf "$TMPTAR" $(dcmd ${PACKAGE}_*.changes))

sudo -E \
 DEB_BUILD_OPTIONS="nocheck" \
 linux64 --uname-2.6 unshare --uts -- $BUILDER --build $BUILDER_OPTS \
    --configfile "$SCRIPT_DIR/pbuilderrc.rebuild" \
    --debbuildopts '-b' \
    --buildresult b2 \
    --logfile logs/${PACKAGE}.build2 \
    --hookdir "$SCRIPT_DIR/pbuilderhooks" \
    --inputfile "$TMPTAR" ${PACKAGE}_*.dsc
xz < logs/${PACKAGE}.build2 > logs/${PACKAGE}.build2.xz
rm -f logs/${PACKAGE}.build2

if [ -f b2/debbindiff.html ]; then
	mv b2/debbindiff.html logs/${PACKAGE}.debbindiff.html
fi
