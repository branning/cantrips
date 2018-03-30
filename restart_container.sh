#!/usr/bin/env bash
#
# restart stopped Docker container

set -o errexit

container=${1?"provide container ID or code name, e.g. $(docker ps -ql)"}

docker start "$container"
docker attach "$container"
