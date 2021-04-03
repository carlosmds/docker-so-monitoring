#! /bin/sh

set -x

echo "INSTALL PANDORA"

wget https://sourceforge.net/projects/pandora/files/Pandora%20FMS%207.0NG/743/Debian_Ubuntu/pandorafms.agent_unix_7.0NG.743.deb \
    && dpkg -i pandorafms.agent_unix_7.0NG.743.deb \
    && apt-get -f install

sed -i 's/remote_config.*/remote_config 1/g' /etc/pandora/pandora_agent.conf
sed -i 's/server_ip.*/server_ip \t172.24.0.5/g' /etc/pandora/pandora_agent.conf

wget https://pandorafms.com/library/files_repository/1363784274.magulinb.memory_plugin \
    && mv 1363784274.magulinb.memory_plugin /etc/pandora/plugins/memory_plugin \
    && chmod +x /etc/pandora/plugins/memory_plugin

echo "module_plugin memory_plugin" >> /etc/pandora/pandora_agent.conf