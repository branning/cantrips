#!/bin/bash
#
# Who installed this file?

usage()
{ cat <<EOF

Usage: `basename $0` <file>

SUMMARY
Who installed this file?

RETURNS
    0 if the file was found in a package
    1 if the file is not installed by a package
EOF
}

error() { echo $@ >&2; exit 1; }

args=`getopt q $*` || { usage; exit 1; }
set -- $args

for i #in $@
do
    case "$i" in 
    -q) opt_quiet=yes; shift;;
    --) shift; break;;
    *)  error "Getopt broke! Found $i"
    esac
done

file=$1
[ -n "$file" ] || { usage; exit 1; }

case $OSTYPE in
darwin*) 
    output=`pkgutil --file-info ${file}`
    if [ "$opt_quiet" = yes ]
    then
        echo "$output" | grep '^pkgid:' | awk '{ print $2 }'
    else
        echo "$output"
    fi
    ;;
linux*)
    if [ -f /etc/debian_version ] 
    then
        dpkg -S ${file}
    fi
    ;;
esac

