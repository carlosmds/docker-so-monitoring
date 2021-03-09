#!/bin/bash

docker-compose up --build --force-recreate app
# --scale-worker=1