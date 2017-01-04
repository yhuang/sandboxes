#!/usr/bin/env bash

yum install -y aide && \
  /usr/sbin/aide --init && \
  cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz && \
  /usr/sbin/aide --check
