#!/usr/bin/env bash

VERSION=2.4

yum install -y libffi-devel python-sphinx PyYAML

ANSIBLE_DIR=/etc/ansible

mkdir -p $ANSIBLE_DIR/ssh && chmod 700 $ANSIBLE_DIR/ssh

mv /tmp/ansible.cfg $ANSIBLE_DIR/ansible.cfg
chown root:root $ANSIBLE_DIR/ansible.cfg

git clone git://github.com/ansible/ansible.git
cd ansible
git checkout stable-$VERSION

make
make install

cd ..
rm -fr ansible
