#!/usr/bin/env bash

mkdir $HOME_DIR/.ssh && chmod 700 $HOME_DIR/.ssh
mv /tmp/authorized_keys $HOME_DIR/.ssh/authorized_keys
chmod 600 $HOME_DIR/.ssh/authorized_keys
chown -R vagrant:vagrant $HOME_DIR

getent group docker || groupadd docker
getent group wheel || groupadd wheel

usermod -aG docker,wheel vagrant
