#!/usr/bin/env bash

while [ $# -ne 0 ]
do
    ARG=$1
    shift
    case $ARG in
    -n)
        TARGET_SERVERS=$1
        shift
        ;;
    *)
        echo "Error: Unknown Argument - $ARG"
        exit 1
        ;;
    esac
done

if [[ $TARGET_SERVERS -ge 10 ]]; then
  $TARGET_SERVERS=9
fi

for i in $(seq 1 $TARGET_SERVERS); do
  echo "base-0$i" >> /etc/ansible/hosts
done
