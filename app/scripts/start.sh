#! /bin/sh

echo "START"

bash -c 'echo "Server Info: " && cat /etc/os-release | grep PRETTY_NAME'

cd /app && npm start