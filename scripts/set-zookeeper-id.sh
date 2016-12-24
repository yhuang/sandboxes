#!/usr/bin/env bash

source /etc/profile.d/consul.sh

echo $MYID > /var/zookeeper/data/myid
