#!/bin/bash

docker-compose up worker --build --force-recreate
# --scale-worker=1