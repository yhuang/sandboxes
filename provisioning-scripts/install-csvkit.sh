#!/usr/bin/env bash

# https://csvkit.readthedocs.io/en/1.0.3/tutorial/1_getting_started.html#installing-csvkit

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 8 ]]; then
    pip3 install csvkit
    pip2 install cvskit
else
    python3 -m pip install csvkit
    pip install csvkit
fi

