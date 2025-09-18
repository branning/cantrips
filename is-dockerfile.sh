#!/bin/sh

thefile=${1?'must give a file argument'}
first4=$(awk 'NF { l=$0; sub(/^[[:space:]]+/, "", l); if(l !~ /^#/){ print tolower(substr(l,1,4)); exit } }' "$thefile")

[ 'from' = "$first4" ]

