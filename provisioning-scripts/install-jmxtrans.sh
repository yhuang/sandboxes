#!/usr/bin/env bash

yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel.x86_64
APPLICATION=jmxtrans
VERSION=259
PACKAGE=${APPLICATION}-${VERSION}.rpm

wget http://central.maven.org/maven2/org/$APPLICATION/$APPLICATION/$VERSION/$PACKAGE
rpm -i $PACKAGE

mv /tmp/yaml2jmxtrans.py /usr/share/jmxtrans/tools/yaml2jmxtrans.py
chmod a+x /usr/share/jmxtrans/tools/yaml2jmxtrans.py

rm -f $PACKAGE
