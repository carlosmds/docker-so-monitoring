#! /bin/sh

set -x

echo "START"

bash -c 'echo "Server Info: \n" && cat /etc/os-release | grep PRETTY_NAME'

cd /app && npm start