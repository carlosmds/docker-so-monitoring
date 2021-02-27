FROM debian:stretch

LABEL maintainer 'Carlos Medeiros - TADS UDESC 2021 - carlosmedeirosdesouza@gmail.com'

ADD . /app
WORKDIR /app

RUN chmod -R +x scripts
RUN DEBIAN_FRONTEND=noninteractive bash -c "cd scripts; ./server-config.sh; ./install-nagios.sh; ./install-pandora.sh; ./install-zabbix.sh; ./install-nodejs-server.sh"

ENTRYPOINT bash -c "/app/scripts/start.sh"