#!/bin/bash

docker-compose build --no-cache app

docker-compose up --build --force-recreate app

# docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" nagios zabbix-app pandora-app

# stress --cpu 2 --vm 2