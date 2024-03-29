#! /bin/sh

set -x

echo "INSTALL NAGIOS"

apt install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext xinetd

mkdir /opt/nagios && cd /opt/nagios

wget https://www.nagios-plugins.org/download/nagios-plugins-2.1.2.tar.gz \
    && tar -xvf nagios-plugins-2.1.2.tar.gz

cd nagios-plugins-2.1.2

./configure \
    && make \
    && make install

useradd nagios \
    && chown nagios.nagios /usr/local/nagios \
    && chown -R nagios.nagios /usr/local/nagios/libexec

cd /usr/local/nagios/libexec \
    && wget https://raw.githubusercontent.com/justintime/nagios-plugins/master/check_mem/check_mem.pl \
    && chmod +x check_mem.pl

cd /opt/nagios/

wget https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz \
    && tar xzf nrpe-3.2.1.tar.gz

cd nrpe-3.2.1

./configure \
    && make all \
    && make install-plugin \
    && make install-daemon \
    && make install-config \
    && make install-inetd

cat /etc/services | grep nrpe

sed -i 's/\# default.*/\# default: on/g' /etc/xinetd.d/nrpe
sed -i 's/disable.*/disable\t    = no/g' /etc/xinetd.d/nrpe
sed -i 's/only_from.*/only_from\t    = 127.0.0.1 localhost 172.24.0.2/g' /etc/xinetd.d/nrpe
sed -i '/log_on_success/d' /etc/xinetd.d/nrpe

sed -i '/nrpe/d' /etc/services \
    && echo >> /etc/services \
    && echo '# Nagios services' >> /etc/services \
    && echo 'nrpe    5666/tcp' >> /etc/services \
    && make install-init

sed -i 's/.*server_address.*/server_address=172.24.0.2/g' /usr/local/nagios/etc/nrpe.cfg
sed -i 's/.*allowed_hosts.*/allowed_hosts=127.0.0.1,::1,172.24.0.2/g' /usr/local/nagios/etc/nrpe.cfg

echo "command[check_mem]=/usr/local/nagios/libexec/check_mem.pl -f -w 20 -c 10" >> /usr/local/nagios/etc/nrpe.cfg

service xinetd restart 
netstat -at | grep nrpe 

sleep 2

/usr/local/nagios/libexec/check_nrpe -H localhost