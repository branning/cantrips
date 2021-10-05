#!/usr/bin/env bash
#
# Delete merged branches, but only if they are not special branches

TEST=${TEST-'echo'}

SPECIAL='
  main
  master
  develop
  \*
  '

join_by() { local IFS="$1"; shift; echo "$*"; }

git branch --merged |
  grep -vE "(`join_by '|' $SPECIAL`)" |
  xargs $TEST git branch -d

if ! [ -z ${TEST-x} ]; then
  echo "* just a test, to really delete run TEST= ${BASH_SOURCE}"
fi

