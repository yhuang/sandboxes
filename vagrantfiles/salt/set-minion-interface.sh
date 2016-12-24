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

sed -i "s/#master: salt/master: $IP/" /etc/salt/minion
sed -i "s/#id:/id: salt-minion/" /etc/salt/minion

systemctl restart salt-minion.service
