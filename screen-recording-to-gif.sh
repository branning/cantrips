#!/usr/bin/env bash
#
# Convert screen recording from QuickTime movie to GIF
# using ffmpeg and gifsicle
#
# from https://stackoverflow.com/questions/28354217/how-can-you-record-your-screen-in-a-gif/28354297#28354297

set +o errexit

VERBOSE=${VERBOSE:-0}

MOV_FILE=${MOV_FILE:-${1:-'in-trimmed.mov'}}
echo "MOV_FILE is ${MOV_FILE}"

DEFAULT_GIF=${MOV_FILE/%mov/gif}
OUT_GIF=${OUT_GIF:-${2:-$DEFAULT_GIF}}
echo "OUT_GIF is ${OUT_GIF}"

check_deps() {
  for pkg in $@
  do
    if ! brew list 2>/dev/null | grep -q "$pkg"
    then
      brew install "$pkg"
    elif ((VERBOSE))
    then echo "ok $pkg"
    fi
  done
}

check_deps ffmpeg gifsicle

ffmpeg -i "$MOV_FILE" -vf "scale=min(iw\,600):-1" -pix_fmt rgb32 -r 10 -f gif - | \
  gifsicle --optimize=3 --delay=7 --colors 128 > "$OUT_GIF"
