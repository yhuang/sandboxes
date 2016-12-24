#!/usr/bin/env bash

# Consul Client Setup
mv /tmp/report-zookeeper-mode.sh /usr/local/bin/report-zookeeper-mode.sh
chmod a+x /usr/local/bin/report-zookeeper-mode.sh

mv /tmp/zookeeper-health-check.json /etc/consul.d/zookeeper-health-check.json

mv /tmp/start-consul-client.sh /usr/local/bin/start-consul-client.sh
chmod a+x /usr/local/bin/start-consul-client.sh

mv /tmp/consul-client.service /etc/systemd/system/consul.service

mv /tmp/replace-with-zookeeper-id.sh /usr/local/bin/replace-with-zookeeper-id.sh
chmod a+x /usr/local/bin/replace-with-zookeeper-id.sh

mkdir -p /etc/systemd/system/consul.service.d
mv /tmp/consul-client.service.override /etc/systemd/system/consul.service.d/override.conf

# Consul Template Setup
mv /tmp/bootstrap-zookeeper.sh /usr/local/bin/bootstrap-zookeeper.sh
chmod a+x /usr/local/bin/bootstrap-zookeeper.sh

mkdir -p /etc/consul-template

mv /tmp/consul-template.cfg /etc/consul-template/consul-template.cfg
mv /tmp/zoo.cfg.ctmpl /etc/consul-template/zoo.cfg.ctmpl

mv /tmp/start-consul-template.sh /usr/local/bin/start-consul-template.sh
chmod a+x /usr/local/bin/start-consul-template.sh

mv /tmp/consul-template.service /etc/systemd/system/consul-template.service

# Zookeeper Setup
mv /tmp/set-zookeeper-id.sh /usr/local/bin/set-zookeeper-id.sh
chmod a+x /usr/local/bin/set-zookeeper-id.sh

mkdir -p /etc/systemd/system/zookeeper.service.d
mv /tmp/zookeeper.service.override /etc/systemd/system/zookeeper.service.d/override.conf

ZOOKEEPER_DIR=/opt/mesosphere/zookeeper
echo "pathmunge $ZOOKEEPER_DIR/bin" > /etc/profile.d/zookeeper.sh

systemctl daemon-reload
