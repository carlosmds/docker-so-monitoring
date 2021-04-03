#!/bin/bash

arquivo="dados/nagios-1s.txt"; 

rm -rf $arquivo; echo -e "CPU(%)\tMEM(MB)" >> $arquivo

docker exec -d docker-so-monitoring_app_1 bash -c 'stress --cpu 1 -t 60; sleep 390; stress --cpu 1 -t 30; stress --vm 1 --vm-bytes 128M -t 30;'

counter=0

while [ $counter -lt 300 ]; do 
    docker stats --no-stream docker-so-monitoring_app_1 | grep docker-so-monitoring_app_1 | awk '{print $3,"\t",$4}' | sed -e 's/%//g' | sed -e 's/MiB//g' >> $arquivo; 
    let "counter+=1" 
done