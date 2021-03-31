#! /bin/sh

bash -c 'echo "Server Info: " && cat /etc/os-release | grep PRETTY_NAME'
echo " " 
# START PANDORA AGENT
/etc/init.d/pandora_agent_daemon start
echo " " 
# START ZABBIX AGENT
service zabbix-agent start
echo " " 
# START NAGIOS NRPE AGENT UNDER XINETD
service xinetd restart
sleep 2 && echo $(netstat -at | grep nrpe) 
/usr/local/nagios/libexec/check_nrpe -H localhost
echo " "

set -x

stress --cpu 1 --vm 1 -t 600
stress --cpu 2 --vm 2 -t 60
stress --cpu 1 --vm 1 -t 360
stress --cpu 1 -t 360
stress --vm 1 -t 360
