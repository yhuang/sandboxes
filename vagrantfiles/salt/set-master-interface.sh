#!/usr/bin/env bash

while [ $# -ne 0 ]
do
    ARG=$1
    shift
    case $ARG in
    --ip)
        IP=$1
        shift
        ;;
    *)
        echo "Error: Unknown Argument - $ARG"
        exit 1
        ;;
    esac
done

sed -i "s/#interface: 0.0.0.0/interface: $IP/" /etc/salt/master

systemctl restart salt-master.service
