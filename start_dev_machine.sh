#!/usr/bin/env bash
#
# start a GCE instance by name and connect to it by SSH when its ready

set -o errexit

error() { echo >&2 "$*"; exit 1; }

# Check for required tools
command -v gcloud >/dev/null 2>&1 || { echo >&2 "I require gcloud but it's not installed.  Aborting."; exit 1; }

instance=${INSTANCE:-'philip-dev-ubu1604'}
zone=${ZONE:-'us-central1-f'}

# GCE instances types: https://cloud.google.com/compute/docs/machine-types 
big_type='n1-standard-8'
small_type='n1-standard-1'

# accept optional "stop" argument
[ -n "$1" ] &&
case "$1" in
  stop)
    # stop the instance, and size it down
    if [[ "$instance" != philip-dev-ubu1604 ]]
    then
      error "Refusing to stop instance ${instance}. Is that what you really want?"
    fi
    gcloud compute instances stop "$instance" --zone "$zone"
    gcloud compute instances set-machine-type "$instance" \
      --zone "$zone" \
      --machine-type="$small_type"

    # remove any previous entries for this hostname
    temp_ssh_config=$(mktemp)
    sed 's/^Host/\n&/' ~/.ssh/config \
      | sed '/^Host '"$instance"'$/,/^$/d;/^$/d' \
      > "$temp_ssh_config"
    if [ ${PIPESTATUS[1]} ]
    then
      # the diff format has `> HostName 0.0.0.0' so the third part is the IP
      ip=$(diff ~/.ssh/config "$temp_ssh_config" | awk '/HostName/ { print $3 }')
      ssh-keygen -R "$ip"
      mv "$temp_ssh_config" ~/.ssh/config 
    else
      rm "$temp_ssh_config"
    fi

    exit 0
    ;;
  *) : ;;
esac

gcloud_status(){
  local instance
  instance=${1:-'philip-dev-ubu1604'}
  gcloud compute instances describe "$instance" --zone "$zone" \
    | awk '/^status/ { print $2 }'
}

case $(gcloud_status "$instance") in
  RUNNING|STAGING|STOPPING) : ;;
  TERMINATED)
    if [[ "$instance" = philip-dev-ubu1604 ]]
    then
      gcloud compute instances set-machine-type "$instance" \
        --zone "$zone" \
        --machine-type="$big_type"
    fi
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

  # write the new host entry for this machine
  cat <<EOF >>~/.ssh/config
Host $instance
  HostName $ip
  User $USER
  IdentityFile ~/.ssh/id_rsa
  StrictHostKeyChecking no
EOF
fi

# wait up to 10 * 5 = 50 seconds for status to be RUNNING
while ((tries++ < 10)) && [ $(gcloud_status "$instance") != RUNNING ]
do
  printf '.' && sleep 5
done

# log in to instance. first one fails, but second succeeds??
ssh "$instance" || ssh "$instance"

