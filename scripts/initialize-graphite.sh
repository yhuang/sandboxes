#!/usr/bin/env bash

sudo -E PYTHONPATH=/opt/graphite/webapp django-admin.py syncdb --settings=graphite.settings
sudo chown apache:apache /opt/graphite/storage/graphite.db

sudo -E /opt/graphite/bin/carbon-cache.py --instance=1 start

sudo systemctl enable httpd
sudo systemctl start httpd

sudo systemctl disable firewalld
sudo systemctl stop firewalld
