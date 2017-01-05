#!/usr/bin/env bash

mkdir -p /etc/system-audit

mv /tmp/cis-benchmark-centos-7.yml /etc/system-audit/cis-benchmark-centos-7.yml
mv /tmp/system-audit.py /usr/local/bin/system-audit.py

chmod a+x /usr/local/bin/system-audit.py
