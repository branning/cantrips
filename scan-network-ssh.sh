#!/bin/sh

# for finding ssh servers on the local network
sudo nmap -O -p 22 --open 192.168.1.0/24
