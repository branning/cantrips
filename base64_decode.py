#!/usr/bin/python3

import base64
import sys

if len(sys.argv) != 2:
    print("Usage: python " + __name__ + " <base64_encoded_string>")
    sys.exit(1)

encoded_string = sys.argv[1]
encoded_bytes = encoded_string.encode()

try:
    decoded_bytes = base64.b64decode(encoded_bytes)
    length_in_bytes = len(decoded_bytes)
    print("Length of decoded data in bytes:", length_in_bytes)
except base64.binascii.Error:
    print("Error: Invalid base64-encoded string provided.")

