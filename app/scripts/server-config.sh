#! /bin/sh

set -x

echo "SERVER CONFIG"

apt update \
    && apt-get install curl wget unzip libzstd1 libselinux1 libc6 perl dialog apt-utils ucf net-tools stress -y

/etc/init.d/dbus start