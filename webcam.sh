#!/bin/bash
#
# launch a window showing the webcam

case $OSTYPE in
  linux*)
    if ! command -v gst-launch-1.0 &>/dev/null
    then
      sudo apt install gstreamer1.0-tools -y
    fi
    gst-launch-1.0 v4l2src ! xvimagesink
    ;;
  *) echo >&2 "not sure how to launch webcame on $OSTYPE yet";;
esac
    
    
