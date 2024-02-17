## Get config of running Linux kernel

cat /proc/config.gz | gunzip > running.config
less running.config
