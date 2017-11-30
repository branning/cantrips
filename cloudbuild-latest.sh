#!/usr/bin/env bash
#
# use gcloud API to tail logs of most recent cloud registry build

# get JSON representation of most recent build (the 'latest')
latest=$(gcloud container builds list --format=json | jq -r ".[0]")

# grab the build ID from the JSON
id=$(jq -r ".id" <(echo "$latest"))

gcloud container builds log --stream "$id" # | LESS=-S less +F
