#!/usr/bin/env bash

# https://csvkit.readthedocs.io/en/1.0.3/tutorial/1_getting_started.html#installing-csvkit
CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 6 ]]; then
    wget -q http://repo.openfusion.net/centos6-x86_64/openfusion-release-0.7-1.o.el6.noarch.rpm
    rpm -Uvh openfusion-release*rpm
    yum install -y csvkit
elif [[ $CENTOS_VERSION -eq 7 ]]; then
    pip2 install --upgrade pip

    pip3 install csvkit
    pip2 install csvkit
elif [[ $CENTOS_VERSION -eq 8 ]]; then
    pip3 install csvkit
    pip2 install csvkit
fi
