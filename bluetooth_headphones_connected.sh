#!/bin/bash
#
# determine if headphones are connected

case $OSTYPE in
  darwin*)
    system_profiler SPBluetoothDataType -xml |
      xmllint --xpath "//*[text()='WH-1000XM3']/following-sibling::dict" - |
      tr -d "[:space:]" | 
      grep -q "device_isconnected</key><string>attrib_Yes"
    ;;
  *)
    echo >&2 "this script only works on MacOS"
    exit 1
    ;;
esac
