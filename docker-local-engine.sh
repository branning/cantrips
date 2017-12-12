#!/usr/bin/env bash
#
# to revert to using localhost docker engine instead of minikube vm docker
# undoes the effect of `eval $(minikube docker-env)`

error() {
  echo "`basename $0` error: $*" >&2
  exit 1
}

# if we are being executed, emit an error. We need to be sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  error "this script must be sourced. try:

    source ${BASH_SOURCE[0]}

instead. Then \`docker info | grep ^Name\` should show 'Name: ${HOSTNAME}'
"
fi

# remvove all environment variables like DOCKER*
for var in $(set | awk -F= '/^DOCKER/ { print $1 }'); do unset $var; done

