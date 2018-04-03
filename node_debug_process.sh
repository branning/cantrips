#!/bin/sh
#
# start your node server: `node server.js`
# then attach to it with the command below:

node inspect -p $(ps -e | awk '/node$/ {print $1}')
