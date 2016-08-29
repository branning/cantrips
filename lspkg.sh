#!/bin/bash
#
# What files are in this package?

usage()
{ cat <<EOF

Usage: `basename $0` <file>

SUMMARY
What files are in this package?

RETURNS
    0 if the package is installed and has files
    1 if the package can't be found
EOF
}

pkg=$1
[ -n "$pkg" ] || { usage; exit 1; }

case $OSTYPE in
darwin*) pkgutil --files ${pkg};;
linux*)
    if [ -f /etc/debian_version ] 
    then
        dpkg -L ${pkg}
    fi
esac

