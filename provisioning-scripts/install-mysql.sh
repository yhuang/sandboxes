#!/usr/bin/env bash

PACKAGE=mysql-community-release-el7-5.noarch.rpm

wget http://repo.mysql.com/$PACKAGE
rpm -ivh $PACKAGE
rm -f $PACKAGE

yum install -y mysql-server

systemctl start mysqld
