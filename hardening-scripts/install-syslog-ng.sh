#!/usr/bin/env bash

yum install -y libnet
yum --disablerepo="*" --enablerepo="epel" install -y syslog-ng
