#!/usr/bin/env bash

# https://csvkit.readthedocs.io/en/1.0.3/tutorial/1_getting_started.html#installing-csvkit
CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 6 ]]; then
    yum install -y csvkit
else
    python3 -m pip install --upgrade pip
    pip2 install --upgrade pip

    python3 -m pip install csvkit
    pip2 install csvkit
fi
