#!/usr/bin/env bash

yum install -y ntp ntpdate
systemctl enable ntpd
ntpdate pool.ntp.org
systemctl start ntpd
