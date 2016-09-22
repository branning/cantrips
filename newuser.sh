#!/bin/bash
#
# Create a new user, home directory, set password, and add to sudoers
# If the docker group exists, also add user to the docker group

set -o errexit
#set -o xtrace

error(){ echo "$@" >&2; exit 1; }
    
# if root directory is writable, we are root-like
[ -w / ] || error "`basename $0` must be run as root"

user=${1}
password=${2-${user}}

printf "Creating user ${user} "
if [ ${user} != ${password} ]
then
    printf 'with given password'
else
    printf 'with default password'
fi
echo # just a line break

# Check whether we already tried this
if grep -q ${user} /etc/passwd
then
    echo "Warning: ${user} already exists, not creating"
else
    # Create user, set password, set bash shell
    useradd -m ${user}
    echo "${user}:${password}" | chpasswd
    usermod -s /bin/bash ${user}
fi

# Add user to sudoers and docker groups, and other default Ubuntu
groups='
    adm
    cdrom
    dip
    docker
    plugdev
    lxd
    lpadmin
    sambashare
    sudo
    '
for group in ${groups}
do
    if grep -q ^${group} /etc/group
    then 
        usermod -aG ${group} ${user}
    fi
done

# Summary
su -c 'echo "User ${USER} with home ${HOME}"; echo "Groups: `groups`"' \
   -s /bin/bash \
   ${user}
