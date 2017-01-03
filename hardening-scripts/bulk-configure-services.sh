#!/usr/bin/env bash

systemctl enable crond
systemctl enable irqbalance
systemctl enable psacct

#yum install at
#systemctl disable atd
systemctl disable certmonger

#systemctl disable cgconfig
systemctl disable cgred
#systemctl disable cpuspeed

#yum install dovecot
#systemctl disable dovecot

#yum install httpd
#systemctl disable httpd
systemctl disable kdump
#systemctl disable mdmonitor
systemctl disable messagebus
#systemctl disable named
systemctl disable netconsole
systemctl disable nfslock
systemctl disable ntpdate

#yum instsall oddjob
#systemctl disable oddjobd

#yum install portreserve
#systemctl disable portreserve

#yum install boost
#yum --disablerepo="*" --enablerepo="epel" install qpid-cpp-client
#yum install cyrus-sasl
#yum --disablerepo="*" --enablerepo="epel" install qpid-cpp-server

#systemctl disable qpidd
#systemctl disable quota_nld
systemctl disable rdisc

#yum -y install rsh rsh-server
#systemctl disable rexec.socket

#yum install rhnsd
#systemctl disable rhnsd

#systemctl disable rhsmcertd

#yum -y install rsh rsh-server
#systemctl disable rlogin.socket

#yum -y install rsh rsh-server
#systemctl disable rsh.socket

#systemctl disable saslauthd
#systemctl disable smartd
#systemctl disable snmpd

#yum install squid
#systemctl disable squid

systemctl disable sysstat

#yum install tftp
#systemctl disable tftp

#yum install xinetd
#systemctl disable xinetd

#yum install ypbind
#systemctl disable ypbind
