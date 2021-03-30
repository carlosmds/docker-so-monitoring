#!/bin/bash

docker network create so-monitoring

cd monitoring-apps/pandora 

docker-compose -f docker-compose-pandora.yml up -d --build --force-recreate

cd - && cd monitoring-apps/zabbix

docker-compose -f docker-compose-zabbix.yml up -d --build --force-recreate

cd - && cd monitoring-apps/nagios

docker-compose -f docker-compose-nagios.yml up -d --build --force-recreate

docker exec -i nagios bash -c '\
    cp -r nagios-config/* /opt/nagios/etc/;\
    cat nagios-config/additional_commands >> /opt/nagios/etc/objects/commands.cfg;\
    echo "cfg_file=/opt/nagios/etc/hosts.cfg" >> /opt/nagios/etc/nagios.cfg;\
    echo "cfg_file=/opt/nagios/etc/services.cfg" >> /opt/nagios/etc/nagios.cfg;'

cd -

echo "
***Informações para acesso às aplicações:
{
    pandora: {
        http://localhost:8010/pandora_console/

        user: 'admin'
        pass: 'pandora'
    }

    nagios: {
        http://localhost:8020

        user: 'nagiosadmin'
        pass: 'nagios'
    }

    zabbix: {
        http://localhost:8030/

        user: 'Admin'
        pass: 'zabbix'
    }
}"