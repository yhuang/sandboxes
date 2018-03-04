#!/usr/bin/env bash

for pkg in salt-master salt-minion salt-ssh salt-syndic salt-cloud; do
  yum --enablerepo=epel install -y $pkg
done

firewall-cmd --permanent --zone=public --add-port=4505-4506/tcp
firewall-cmd --reload
