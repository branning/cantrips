#!/bin/sh
#
# Find the local IP by munging ipconfig output

# windows has ipconfig
case `basename $(type -p ipconfig ifconfig)` in
ipconfig)
    ipconfig \
        | grep 'IPv4 Address' \
        | grep -v '127.0.0.1' \
        | egrep -o '(([0-9]{1,3}\.){3}[0-9]{1,3})'
    ;;
ifconfig)
    ifconfig \
        | grep '^\s*inet[^6]' \
        | grep -v '127.0.0.1' \
        | awk '{ print $2 }'
    ;;
*)  echo 2>&1 "Must have ipconfig or ifconfig available to get IP address"
    exit 1
    ;;
esac
