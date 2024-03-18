#!/usr/bin/env python3

import sys
import zlib

def main():
    if len(sys.argv) != 2:
        print(f"Usage: {__file__} <filename>")
        sys.exit(1)
    filename = sys.argv[1]

    try:
        with open(filename, 'rb') as file:
            data = file.read()
            checksum = zlib.crc32(data)
            print(f"The CRC32 checksum is: {checksum}")
    except IOError:
        print(f"Could not read file: {filename}")

if __name__ == "__main__":
    main()

