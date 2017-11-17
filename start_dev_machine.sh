#!/usr/bin/env bash
#
# start a GCE instance by name and connect to it by SSH when its ready

set -o errexit

error() { echo >&2 "$*"; exit 1; }

# Check for required tools
command -v gcloud >/dev/null 2>&1 || { echo >&2 "I require gcloud but it's not installed.  Aborting."; exit 1; }

instance=${INSTANCE:-'philip-dev-ubu1604'}
zone=${ZONE:-'us-central1-f'}

status=$(gcloud compute instances describe "$instance" --zone "$zone" \
           | awk '/^status/ { print $2 }')
case "$status" in
  RUNNING|STAGING) : ;;
  TERMINATED)
    gcloud compute instances start "$instance" --zone "$zone"
    ;;
  *)  error "weird status returned for instance ${instance}: ${status}";;
esac

# see if our instance has an entry in the SSH config file
if ! grep -q "Host $instance" ~/.ssh/config
then
  # get the IP
  ip=$(gcloud compute instances describe \
         --zone "$zone" \
         "$instance" \
         --format=json \
    | jq -r ".networkInterfaces[0].accessConfigs[0].natIP")
  cat <<EOF >>~/.ssh/config
Host $instance
  HostName $ip
  User $USER
  IdentityFile ~/.ssh/id_rsa
EOF
fi

# log in to instance
ssh "$instance"

# stop the instance!
#gcloud compute instances stop "$instance" --zone "$zone"
