#!/usr/bin/env bash

mkdir -p /etc/system-audit/cis-benchmark-checks

mv /tmp/cis-benchmark-checks/*.sh /etc/system-audit/cis-benchmark-checks
chmod a+x /etc/system-audit/cis-benchmark-checks/*.sh

rm -fr /tmp/cis-benchmark-checks
