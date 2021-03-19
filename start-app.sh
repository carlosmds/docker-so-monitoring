#!/bin/bash

docker-compose build --no-cache app

docker-compose up --build --force-recreate app
# --scale-worker=1