#!/bin/bash
#
# Find live hosts on local network with nmap

quiet() { $@ >/dev/null 2>&1; }
error() { echo 2>&1 "$@"; }

if ! quiet command -v nmap
then
    error "You must install nmap."
    case $OSTYPE in
        darwin*)  error 'Maybe try `brew install nmap`';;
        linux*)   error 'Maybe try `apt-get install nmap`';;
    esac
fi

base_ip=${1-192.168.2.1}
nmap -sP ${base_ip}/24

