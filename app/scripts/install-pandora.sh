#! /bin/sh

set -x

echo "install pandora"

wget https://sourceforge.net/projects/pandora/files/Pandora%20FMS%207.0NG/743/Debian_Ubuntu/pandorafms.agent_unix_7.0NG.743.deb \
    && dpkg -i pandorafms.agent_unix_7.0NG.743.deb \
    && apt-get -f install

/etc/init.d/pandora_agent_daemon start