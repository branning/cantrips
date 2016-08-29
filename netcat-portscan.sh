#!/bin/bash
#
# Use netcat (nc) to perform a port scan

myip=`./myip.sh`
subnet=${myip%%.[0-9]}
port=${1-9999}
for octet in {1..255}
do
    nc -v -z -n -G 1 192.168.2.${octet} ${port}
done
