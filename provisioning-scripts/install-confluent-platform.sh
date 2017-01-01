#!/usr/bin/env bash

mv /tmp/confluent.repo /etc/yum.repos.d/confluent.repo

yum clean all

yum install -y confluent-platform-2.11
