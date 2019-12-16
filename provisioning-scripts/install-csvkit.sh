#!/usr/bin/env bash

# https://csvkit.readthedocs.io/en/1.0.3/tutorial/1_getting_started.html#installing-csvkit
CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 6 ]]; then
    # https://centos.pkgs.org/6/openfusion-x86_64/csvkit-0.6.1-1.of.el6.noarch.rpm.html
    wget http://repo.openfusion.net/centos6-x86_64/openfusion-release-0.7-1.of.el6.noarch.rpm
    rpm -Uvh openfusion-release*rpm
    yum install -y csvkit
    rm -f openfusion-release*rpm
else
    python3 -m pip install --upgrade pip
    pip2 install --upgrade pip

    python3 -m pip install csvkit
    pip2 install csvkit
fi
