#! /bin/sh

set -x

echo "START"

bash -c 'echo \"Server Info: \n\" cat /etc/os-release'

cd /app && npm start