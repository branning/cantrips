#!/bin/sh

SQLITE=${1?"provide .sqlite file to open"}

uvx pipx run litecli "$SQLITE"
