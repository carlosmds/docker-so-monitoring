#! /bin/sh

bash -c 'echo "Server Info: " && cat /etc/os-release | grep PRETTY_NAME'

# START PANDORA AGENT
/etc/init.d/pandora_agent_daemon start

# START ZABBIX AGENT
service zabbix-agent start

# START NAGIOS NRPE AGENT
service nrpe start
/etc/init.d/nagios-nrpe-server restart

# START MAIN APPLICATION
cd /app && npm start