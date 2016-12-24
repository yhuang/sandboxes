#!/usr/bin/env bash

source /etc/profile.d/consul.sh

exec sed -i "s|%MYID%|$MYID|" /etc/consul.d/zookeeper-health-check.json
