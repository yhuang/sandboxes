#!/usr/bin/env bash

systemctl enable crond
systemctl enable irqbalance
systemctl enable psacct

# yum install -y at
# systemctl disable atd

# yum install -y certmonger
# systemctl disable certmonger

# yum install -y libcgroup-tools
# systemctl disable cgconfig
# systemctl disable cgred

# yum install -y dovecot
# systemctl disable dovecot

# yum install -y httpd
# systemctl disable httpd

systemctl disable kdump

# yum install -y mdadm
# systemctl disable mdmonitor

systemctl disable messagebus

# yum install -y bind bind-utils
# systemctl disable named

systemctl disable netconsole
systemctl disable nfs
systemctl disable nfslock
systemctl disable ntpdate
systemctl disable rdisc
systemctl disable rpcbind
systemctl disable rsyncd
systemctl disable sysstat

# yum install -y oddjob
# systemctl disable oddjobd

# yum install -y portreserve
# systemctl disable portreserve

# yum install -y boost
# yum --disablerepo="*" --enablerepo="epel" install qpid-cpp-client
# yum install -y cyrus-sasl
# yum --disablerepo="*" --enablerepo="epel" install qpid-cpp-server
# systemctl disable qpidd
# systemctl disable saslauthd

# yum install -y rsh rsh-server
# systemctl disable rexec.socket

# yum install -y rhnsd
# systemctl disable rhnsd

# yum -y install rsh rsh-server
# systemctl disable rlogin.socket
# systemctl disable rsh.socket

# yum install -y smartmontools
# systemctl disable smartd

# yum install -y net-snmp
# systemctl disable snmpd

# yum install -y squid
# systemctl disable squid

# yum install -y tftp tftp-server
# systemctl disable tftp

# yum install -y xinetd
# systemctl disable xinetd

# yum install -y ypbind
# systemctl disable ypbind
