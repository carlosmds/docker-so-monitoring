#!/bin/bash

cd monitoring-apps/pandora && docker-compose -f docker-compose-pandora.yml up -d && cd -
cd monitoring-apps/zabbix && docker-compose -f docker-compose-zabbix.yml up -d && cd -
cd monitoring-apps/nagios && docker-compose -f docker-compose-nagios.yml up -d && cd -

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
        http://localhost:8020/adagios -> alternativa de interface
        http://localhost:8020/nrdp -> não sei exatamente pra que serve...

        user: 'nagiosadmin'
        pass: 'nagios'

        grafana: {
            http://localhost:3003

            user: 'admin'
            pass: 'admin'
        }
    }

    zabbix: {
        http://localhost:8030/

        user: 'Admin'
        pass: 'zabbix'
    }
}"