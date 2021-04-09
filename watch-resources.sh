#!/bin/bash

ferramenta='ferramenta'
tempo='tempo'

arquivo="dados/$ferramenta-$tempo.txt"; 

rm -rf $arquivo; echo -e "CPU(%)\tMEM(MB)" >> $arquivo

docker exec -d docker-so-monitoring_app_1 bash -c 'sleep 10;  stress --cpu 1 --vm 1 --vm-bytes 128M -t 120;'

script -q -c "echo -e \"CPU(%)\tMEM(MB)\"; timeout 140 docker stats docker-so-monitoring_app_1 | grep -i --line-buffered docker-so-monitoring_app_1 | awk '{print substr(\$3, 1, length(\$3) - 1),\"\\t\",substr(\$4, 1, length(\$4) - 3)}'" -f $arquivo

sed -i 's/\./,/g' $arquivo