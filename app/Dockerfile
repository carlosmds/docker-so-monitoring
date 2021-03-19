FROM alehaa/debian-systemd:stretch

LABEL maintainer 'Carlos Medeiros - TADS UDESC 2021 - carlosmedeirosdesouza@gmail.com'

ADD . /app
WORKDIR /app

RUN echo exit 0 > /usr/sbin/policy-rc.d

RUN chmod -R +x scripts
RUN DEBIAN_FRONTEND=noninteractive bash -c "cd scripts; ./server-config.sh; ./install-nodejs-server.sh; ./install-nagios.sh; ./install-pandora.sh; ./install-zabbix.sh"

ENTRYPOINT bash -c "/app/scripts/start.sh"