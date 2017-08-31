#!/usr/bin/env bash

ANSIBLE_DIR=/etc/ansible

mkdir -p $ANSIBLE_DIR/ssh && chmod 700 $ANSIBLE_DIR/ssh

mv /tmp/ansible.cfg $ANSIBLE_DIR/ansible.cfg
chown root:root $ANSIBLE_DIR/ansible.cfg

yum install -y PyYAML python-jinja2 python-pyasn1 PyYAML
yum --disablerepo="*" --enablerepo="epel" install -y python-keyczar
yum --disablerepo="*" --enablerepo="epel" install -y ansible
