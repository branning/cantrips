#!/bin/sh
#
# if we are running in a container, then we are using anything but `init` or
# `systemd` as PID 1

error(){ echo >&2 "$*"; exit 1; }

[ -r /proc/1/sched ] || error "cannot read /proc/1/sched. is this Linux?"
command -v awk >/dev/null 2>&1 || error "awk is required to run $0"

# First line of /proc/1/sched will be like
#     
#     systemd (1, #threads: 1)
#
# if we are NOT running in a container. otherwise, if we are in a container then
# the executable listed there could be whatever is the entry point of the
# container.
pid1=$(awk 'NR==1 { print $1 }' /proc/1/sched)
! ([ "$pid1" = init ] || [ "$pid1" = systemd ])
