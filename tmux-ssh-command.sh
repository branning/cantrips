#!/bin/sh
#
# Within a Tmux session, it can be useful to resume an SSH connection when the server restarts
# e.g. while true; do if ! ssh q8-hitl journalctl -fu anylink; then sleep 5; fi; done

SERVER=${SERVER-'q8-hitl'}
COMMAND=${COMMAND-'journalctl -fu anylink'}

while true; do if ! ssh "$SERVER" "$COMMAND"; then sleep 5; fi; done