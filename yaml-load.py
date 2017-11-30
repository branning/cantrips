#!/usr/bin/env python3
#

from sys import stdin
import yaml

data = yaml.load(stdin.read())

print(data)
