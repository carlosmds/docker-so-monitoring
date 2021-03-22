#! /bin/sh

set -x

echo "INSTALL ZABBIX"

apt-get install zabbix-agent -y

sed -i "s/127.0.0.1*/172.24.0.3/g" /etc/zabbix/zabbix_agentd.conf
