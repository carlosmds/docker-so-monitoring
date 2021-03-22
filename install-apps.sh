#!/bin/bash

docker network create so-monitoring

cd monitoring-apps/pandora 

docker-compose -f docker-compose-pandora.yml up -d --build --force-recreate

cd - && cd monitoring-apps/zabbix

docker-compose -f docker-compose-zabbix.yml up -d --build --force-recreate

cd - && cd monitoring-apps/nagios

docker-compose -f docker-compose-nagios.yml up -d --build --force-recreate

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