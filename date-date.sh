#!/bin/sh
#
# Set date on remote system with current date output
# Kind of works!

remote=${1?'Expected remote host'}
ssh "$remote" date $(date "+%m%d%H%M%Y.%S")

