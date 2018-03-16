#!/usr/bin/env bash

#cat <<EOF > .ycm_extra_conf.py
indent='             '
cat <<EOF 
#!/usr/bin/env python
#
# Hint: just replace the strings in the flags variable with compilation flags
# necessary for your project. That should be enough for 99% of projects.
#
# https://github.com/Valloric/YouCompleteMe#option-2-provide-the-flags-manually


def FlagsForFile( filename, **kwargs ):
  return {
    'flags': [ 
$(for foo in $(PKG_CONFIG_PATH=$(find ~/gst-build -name pkgconfig -type d | tr '\n' :) pkg-config --cflags --libs gstreamer-webrtc-1.0 gstreamer-sdp-1.0 libsoup-2.4 json-glib-1.0)
    do printf "$indent'$foo',\n"
  done)
             ],
  }
EOF
