#!/usr/bin/env bash

VAGRANT_USER_HOME=/home/vagrant

mv /tmp/vagrant $VAGRANT_USER_HOME/.ssh/vagrant
chmod 600 $VAGRANT_USER_HOME/.ssh/vagrant
