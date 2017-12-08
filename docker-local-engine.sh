#!/usr/bin/env bash
#
# to revert to using localhost docker engine instead of minikube vm docker
# undoes the effect of `eval $(minikube docker-env)`

for var in $(set | awk -F= '/^DOCKER/ { print $1 }'); do unset $var; done
