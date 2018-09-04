#!/usr/bin/env bash

mkdir -p $HOME_DIR

mv /tmp/kafka.yml /tmp/kafka-dashboard.txt /tmp/server*.properties $HOME_DIR
mv /tmp/start-confluent.sh /tmp/initialize-graphite.sh /tmp/jmxtrans.sh $HOME_DIR

chmod a+x $HOME_DIR/start-confluent.sh
chmod a+x $HOME_DIR/initialize-graphite.sh
chmod a+x $HOME_DIR/jmxtrans.sh

VERSION=259
PACKAGE=jmxtrans-$VERSION-all.jar

wget -O $HOME_DIR/$PACKAGE http://central.maven.org/maven2/org/jmxtrans/jmxtrans/$VERSION/$PACKAGE

chown -R vagrant:vagrant $HOME_DIR
