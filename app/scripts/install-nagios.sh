#! /bin/sh

set -x

echo "INSTALL NAGIOS"

useradd nagios

apt install -y autoconf gcc libmcrypt-dev make libssl-dev wget dc build-essential gettext

cd ~
curl -L -O https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz

tar zxf nagios-plugins-2.2.1.tar.gz
cd nagios-plugins-2.2.1

./configure

make

make install

cd ~
curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz

tar zxf nrpe-3.2.1.tar.gz

cd nrpe-3.2.1

./configure --enable-command-args

make all

make install-groups-users

make install

make install-config

echo >> /etc/services
echo '# Nagios services' >> /etc/services
echo 'nrpe    5666/tcp' >> /etc/services
make install-init

/usr/bin/install -c -m 644 startup/default-service /lib/systemd/system/nrpe.service

sed -i 's/.*server_address.*/server_address=172.24.0.4/g' /usr/local/nagios/etc/nrpe.cfg
sed -i 's/.*allowed_hosts.*/allowed_hosts=127.0.0.1,::1,172.24.0.4/g' /usr/local/nagios/etc/nrpe.cfg
sed -i 's/.*hda1.*/command[check_root]=\/usr\/local\/nagios\/libexec\/check_disk -w 20% -c 10% -p \//g' /usr/local/nagios/etc/nrpe.cfg