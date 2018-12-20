#!/bin/sh
#

case $1 in
  'ext')
    # look at extensions, little imprecise
    find . | egrep -o '\.{1}\w*$' | sort | uniq -c | sort
    ;;
  *)
    # use `file` to determine filetypes rather than extensions
    find . | xargs file - | awk '{$1=""}1' | cut -d, -f1 | sort | uniq -c | sort
esac

