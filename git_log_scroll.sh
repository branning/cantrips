#!/bin/sh
#
# Scroll through recent Git commits

help() {
cat <<'EOF'

Show diffs of recent Git commits. We're just calling `git show HEAD~` and
incrementing the HEAD~ counter, so you're viewing diffs in `less`.

To see the next commmit:

    type `q` (you're quitting `git show`, and opening the next commit)

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
  if ! git show "HEAD~$n"
  then
    break
  fi
  n=$((n+1))
done
