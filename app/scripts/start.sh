#! /bin/sh

bash -c 'echo "Server Info: " && cat /etc/os-release | grep PRETTY_NAME'

# START PANDORA AGENT
/etc/init.d/pandora_agent_daemon start

# START ZABBIX AGENT
service zabbix-agent start

# START NAGIOS NRPE AGENT UNDER XINETD
service xinetd restart
sleep 2 && echo $(netstat -at | grep nrpe) 
/usr/local/nagios/libexec/check_nrpe -H localhost

# START MAIN APPLICATION
cd /app && npm start