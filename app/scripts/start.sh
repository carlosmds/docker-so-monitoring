#! /bin/sh

bash -c 'echo "Server Info: " && cat /etc/os-release | grep PRETTY_NAME'

# echo ; echo "START PANDORA AGENT"; /etc/init.d/pandora_agent_daemon start

# echo ; echo "START ZABBIX AGENT"; service zabbix-agent start;

echo ; echo "START NAGIOS AGENT NRPE AGENT UNDER XINETD"; echo ; service xinetd restart; sleep 5; echo "Netstat:"; echo $(netstat -at | grep nrpe);\
    /usr/local/nagios/libexec/check_nrpe -H localhost

touch keep_alive && tail -f keep_alive