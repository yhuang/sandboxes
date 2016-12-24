#!/usr/bin/env bash

# Marathon is the init/systemd/upstart for Apache Mesos
systemctl enable marathon
systemctl start marathon

# Chronos is the cron for Apache Mesos
systemctl enable chronos
systemctl start chronos

systemctl stop mesos-slave.service
systemctl disable mesos-slave.service

# Consul Client Setup
mv /tmp/start-consul-client.sh /usr/local/bin/start-consul-client.sh
chmod a+x /usr/local/bin/start-consul-client.sh

mv /tmp/consul-client.service /etc/systemd/system/consul.service

# Consul Template Setup
mkdir -p /etc/consul-template

mv /tmp/mesos-master-consul-template.cfg /etc/consul-template/consul-template.cfg
mv /tmp/zk.ctmpl /etc/consul-template/zk.ctmpl

mv /tmp/start-consul-template.sh /usr/local/bin/start-consul-template.sh
chmod a+x /usr/local/bin/start-consul-template.sh

mv /tmp/consul-template.service /etc/systemd/system/consul-template.service

mv /tmp/ /usr/local/bin/start-consul-template.sh
chmod a+x /usr/local/bin/start-consul-template.sh

systemctl daemon-reload

systemctl restart mesos-master marathon chronos
