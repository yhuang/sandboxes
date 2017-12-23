#!/usr/bin/env bash

VAGRANT_USER_HOME=/home/vagrant

mkdir $VAGRANT_USER_HOME/.ssh && chmod 700 $VAGRANT_USER_HOME/.ssh
mv /tmp/authorized_keys $VAGRANT_USER_HOME/.ssh/authorized_keys
chmod 600 $VAGRANT_USER_HOME/.ssh/authorized_keys
chown -R vagrant:vagrant $VAGRANT_USER_HOME

getent group docker || groupadd docker
getent group wheel || groupadd wheel

usermod -aG docker,wheel vagrant
