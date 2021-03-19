#! /bin/sh

set -x

echo "INSTALL ZABBIX"

apt-get install zabbix-agent -y

sed -i "s/127.0.0.1*/172.17.0.1:10051/g" /etc/zabbix/zabbix_agentd.conf

service zabbix-agent start
