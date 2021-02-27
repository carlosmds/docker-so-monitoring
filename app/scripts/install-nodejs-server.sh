#! /bin/sh

set -x

echo "INSTALL NODEJS SERVER"

curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt install nodejs build-essential -y