#!/bin/sh
#
# Find the local IP by munging ipconfig output

ifconfig \
    | grep '^\s*inet[^6]' \
    | grep -v '127.0.0.1' \
    | awk '{ print $2 }'
