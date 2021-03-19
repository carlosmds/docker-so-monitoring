#! /bin/sh

set -x

echo "SERVER CONFIG"

apt update \
    && apt-get install curl wget unzip libzstd1 libselinux1 libc6 perl dialog apt-utils ucf -y

echo N | tee /sys/module/overlay/parameters/metacopy

/etc/init.d/dbus start