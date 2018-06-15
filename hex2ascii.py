#!/usr/bin/env python3
#
# read string representation of hexadecimal ASCII from stdin and print ASCII
# text
#
# $ echo '52 46 42 20 30 30 33 2e 30 30 38 0a' | ./hex2ascii.py 
# RFB 003.008
#
# $

from codecs import decode

def hex2ascii(hexstring):
  """convert string representation of hexadecimal ASCII to ASCII text

  >>> hex2ascii('52 46 42 20 30 30 33 2e 30 30 38 0a')
  b'RFB 003.008\n'
  """
  hexstring = ''.join(hexstring.split()) # remove whitespace
  ascii_bytes = decode(hexstring, 'hex')
  return ascii_bytes.decode('utf-8')

if __name__=="__main__":
  from sys import stdin
  print(hex2ascii(stdin.read()))
