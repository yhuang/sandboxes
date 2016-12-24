#!/usr/bin/env bash

MODE=$(echo stat | nc localhost 2181 | grep Mode | cut -d ' ' -f 2)

case $MODE in
  follower)
    echo "This Zookeeper server is a follower."
    exit 0
    ;;
  leader)
    echo "This Zookeeper server is the leader."
    exit 0
    ;;
  standalone)
    echo "This Zookeeper server is running in standalone mode."
    exit 0
    ;;
  *)
    echo "Error: This Zookeeper server is in an unknown state [${MODE}]!"
    exit 1
    ;;
esac
