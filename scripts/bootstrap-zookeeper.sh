#!/usr/bin/env bash

source /etc/profile.d/consul.sh

# This script will enable and start zookeeper after the number of expected servers
# declared in the /etc/zookeeper/conf/zoo.cfg file has been reached.

BOOTSTRAPPED=/etc/zookeeper/conf/bootstrapped
ZK_NODES_FOUND=$(grep -c '^server\.[[:digit:]]\+=..*' /etc/zookeeper/conf/zoo.cfg)
OUR_IP=$(ip -o -4 addr list ens32 | awk '{print $4}' | cut -d/ -f1)
OUR_IP_FOUND=$(grep -c "^server\.[[:digit:]]\+=$OUR_IP.*" /etc/zookeeper/conf/zoo.cfg)

if [ -z "$ZOOKEEPER_QUORUM" ]; then
    printf "A required environment variable (ZOOKEEPER_QUORUM) is missing.\n \
  Bootstrapping cannot start, so the Zookeeper service will remain disabled.\n"
else
    if [ ! -f $BOOTSTRAPPED ]; then
        if [ $ZK_NODES_FOUND -eq $ZOOKEEPER_QUORUM ]; then
            if [ $OUR_IP_FOUND -gt 0 ]; then
                printf "Detected [$ZK_NODES_FOUND] Zookeeper servers, each with Consul agent installed.\n \
  This number matches the quorum of [$ZOOKEEPER_QUORUM] servers expected, and our IP [$OUR_IP] is among the Zookeeper servers detected.\n \
  Bootstrapping may commence.\n"

                systemctl enable zookeeper && \
                systemctl restart zookeeper && \
                touch $BOOTSTRAPPED
            else
                printf "Detected [$ZK_NODES_FOUND] Zookeeper servers, each with Consul agent installed.\n \
  This number matches the quorum of [$ZOOKEEPER_QUORUM] servers expected, but our IP [$OUR_IP] is not among the Zookeeper servers detected.\n \
  We will assume that the Zookeeper ensemble is in flux, so our ocal Zookeeper service, along with the Consul agent and Consul Template service, will be disabled.\n"

                systemctl disable consul consul-template zookeeper && \
                systemctl stop consul consul-template zookeeper && \
                touch $BOOTSTRAPPED
            fi
        elif [ $ZK_NODES_FOUND -gt $ZOOKEEPER_QUORUM ]; then
            printf "Detected [$ZK_NODES_FOUND] Zookeeper servers, each with Consul agent installed.\n \
  This number is more than the quorum of [$ZOOKEEPER_QUORUM] servers expected, and our IP [$OUR_IP] is among the Zookeeper servers detected.\n \
  We will assume that the Zookeeper ensemble is in flux, so our local Zookeeper service, along with the Consul agent and Consul Template service, will be disabled.\n"

            systemctl disable consul consul-template zookeeper && \
            systemctl stop  consul consul-template zookeeper && \
            touch $BOOTSTRAPPED
        else
            printf "Detected [$ZK_NODES_FOUND] Zookeeper servers, each with Consul agent installed.\n \
  This number is fewer than the quorum of [$ZOOKEEPER_QUORUM] servers expected, so bootstrapping may not commence.\n"
        fi
    else
        printf "Detected [$BOOTSTRAPPED], so this Zookeeper server has been bootstrapped once already.\n"
    fi
fi
