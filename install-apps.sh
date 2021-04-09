#!/bin/bash

docker network create --driver bridge --subnet=172.24.0.0/24 --gateway=172.24.0.1  so-monitoring

cd monitoring-apps/pandora 

docker-compose -f docker-compose-pandora.yml up -d --build --force-recreate

cd - && cd monitoring-apps/zabbix

docker-compose -f docker-compose-zabbix.yml up -d --build --force-recreate

cd - && cd monitoring-apps/nagios

docker-compose -f docker-compose-nagios.yml down

docker-compose -f docker-compose-nagios.yml up -d --build --force-recreate

docker exec -i nagios bash -c '\
    cp -r nagios-config/* /opt/nagios/etc/;\
    cat nagios-config/additional_commands >> /opt/nagios/etc/objects/commands.cfg;\
    echo "cfg_file=/opt/nagios/etc/hosts.cfg" >> /opt/nagios/etc/nagios.cfg;\
    echo "cfg_file=/opt/nagios/etc/services.cfg" >> /opt/nagios/etc/nagios.cfg;'

docker-compose -f docker-compose-nagios.yml restart

cd -

echo '
***Coletar dados dos containers: 
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" nagios zabbix-app pandora-app'

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

script -q -c "echo -e \"CPU(%)\tMEM(MB)\"; timeout 20 docker stats nagios | grep -i --line-buffered nagios | awk '{print substr(\$3, 1, length(\$3) - 1),\"\\t\",substr(\$4, 1, length(\$4) - 3)}'" -f dados/nagios-server.txt
script -q -c "echo -e \"CPU(%)\tMEM(MB)\"; timeout 20 docker stats zabbix-app | grep -i --line-buffered zabbix-app | awk '{print substr(\$3, 1, length(\$3) - 1),\"\\t\",substr(\$4, 1, length(\$4) - 3)}'" -f dados/zabbix-server.txt
script -q -c "echo -e \"CPU(%)\tMEM(MB)\"; timeout 20 docker stats pandora-app | grep -i --line-buffered pandora-app | awk '{print substr(\$3, 1, length(\$3) - 1),\"\\t\",substr(\$4, 1, length(\$4) - 3)}'" -f dados/pandora-server.txt

sed -i 's/\./,/g' dados/nagios-server.txt
sed -i 's/\./,/g' dados/zabbix-server.txt
sed -i 's/\./,/g' dados/pandora-server.txt