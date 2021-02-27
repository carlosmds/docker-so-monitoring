#! /bin/sh

set -x

echo "SERVER CONFIG"
echo "ENVIRONMENT UID IS $UID"

apt update \
    && apt install curl -y
    