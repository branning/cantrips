#!/bin/sh
#
# Scroll through recent Git commits

help() {
cat <<'EOF'

Show the diff patch for the stashes you've saved.

To see the next stash:

    type `q` (you're quitting `git show`, and opening the next stash)

To quit:

    Ctrl+C, then `q`

EOF
}

error(){ echo >&2 "$*"; exit 1; }

if [ -n "$1" ]
then
  case $1 in
    -h|--help|help) help; exit 0;;
    *)         error "Unknown option $1";;
  esac
fi

n=0
while true
do
  if ! git stash show -p "stash@{$n}"
  then
    break
  fi
  n=$((n+1))
done
