#!/usr/bin/env bash

# https://beyondgrep.com/install
yum --disablerepo="*" --enablerepo="epel" install -y ack
