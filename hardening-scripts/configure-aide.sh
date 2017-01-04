#!/usr/bin/env bash

echo "0 3 * * * root /usr/sbin/aide --check" >> /etc/crontab

systemctl restart crond.service
