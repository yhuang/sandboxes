#!/usr/bin/env bash

echo "install dccp /bin/true" > /etc/modprobe.d/dccp.conf
echo "install rds /bin/true" > /etc/modprobe.d/rds.conf
echo "install sctp /bin/true" > /etc/modprobe.d/sctp.conf
echo "install tipc /bin/true" > /etc/modprobe.d/tipc.conf
