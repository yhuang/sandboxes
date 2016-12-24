#!/usr/bin/env bash

TRAINING_DIR=/home/vagrant

sudo systemctl stop iptables
sudo systemctl disable iptables

sudo zookeeper-server-stop
sudo zookeeper-server-start -daemon /etc/kafka/zookeeper.properties

sleep 5

sudo JMX_PORT=9990 LOG_DIR=/var/log/kafka0 kafka-server-start -daemon $TRAINING_DIR/server0.properties
sudo JMX_PORT=9991 LOG_DIR=/var/log/kafka1 kafka-server-start -daemon $TRAINING_DIR/server1.properties
sudo JMX_PORT=9992 LOG_DIR=/var/log/kafka2 kafka-server-start -daemon $TRAINING_DIR/server2.properties

# the startup scripts here don't properly daemonize, so I need to do it here
sudo nohup schema-registry-start /etc/schema-registry/schema-registry.properties </dev/null &>/dev/null &
sudo nohup kafka-rest-start /etc/kafka-rest/kafka-rest.properties </dev/null &>/dev/null &

yaml2jmxtrans $TRAINING_DIR/kafka.yml

JAR_FILE=jmxtrans-259-all.jar $TRAINING_DIR/jmxtrans.sh start
