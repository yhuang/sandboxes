#!/usr/bin/env bash

rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-2.noarch.rpm
yum install -y mesosphere-zookeeper

mkdir -p /var/zookeeper/{data,log}

# Zookeeper will be enabled and booted later, when the consul-template updates
# zoo.cfg with the required number of bootstrap zookeeper servers.
systemctl disable zookeeper
