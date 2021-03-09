#! /bin/sh

set -x

echo "SERVER CONFIG"

apt update \
    && apt-get install curl wget unzip systemd perl -y

echo N | tee /sys/module/overlay/parameters/metacopy

/etc/init.d/dbus start

echo "ENVIRONMENT UID IS $UID"