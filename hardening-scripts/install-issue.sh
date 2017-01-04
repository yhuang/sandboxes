#!/usr/bin/env bash

mv /tmp/issue /etc/issue
cp /etc/issue /etc/issue.net

chown root:root /etc/issue /etc/issue.net
chmod 644 /etc/issue /etc/issue.net
