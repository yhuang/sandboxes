#!/usr/bin/env bash

TRAINING_DIR=/home/vagrant

mkdir -p $TRAINING_DIR

mv /tmp/kafka.yml /tmp/kafka-dashboard.txt /tmp/server*.properties $TRAINING_DIR
mv /tmp/start-confluent.sh /tmp/initialize-graphite.sh /tmp/jmxtrans.sh $TRAINING_DIR

chmod a+x $TRAINING_DIR/start-confluent.sh
chmod a+x $TRAINING_DIR/initialize-graphite.sh
chmod a+x $TRAINING_DIR/jmxtrans.sh

VERSION=259
PACKAGE=jmxtrans-$VERSION-all.jar

wget -O $TRAINING_DIR/$PACKAGE http://central.maven.org/maven2/org/jmxtrans/jmxtrans/$VERSION/$PACKAGE

chown -R vagrant:vagrant $TRAINING_DIR
