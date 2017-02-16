#!/usr/bin/env bash

ANSIBLE_DIR=/etc/ansible

mkdir -p $ANSIBLE_DIR/ssh && chmod 700 $ANSIBLE_DIR/ssh

mv /tmp/ansible.cfg $ANSIBLE_DIR/ansible.cfg
chown root:root $ANSIBLE_DIR/ansible.cfg

VAGRANT_USER_HOME=/home/vagrant

mv /tmp/vagrant $VAGRANT_USER_HOME/.ssh/vagrant
chmod 600 $VAGRANT_USER_HOME/.ssh/vagrant

yum install -y python-jinja2 python-pyasn1
yum --disablerepo="*" --enablerepo="epel" install -y python-keyczar
yum --disablerepo="*" --enablerepo="epel" install -y ansible
