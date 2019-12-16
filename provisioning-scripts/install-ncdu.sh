#!/usr/bin/env bash

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 6 ]]; then
    yum install -y ncdu
else
    # https://software.opensuse.org//download.html?project=utilities&package=ncdu
    curl https://download.opensuse.org/repositories/utilities/RHEL_7/utilities.repo -o /etc/yum.repos.d/utilities.repo
    yum install -y ncdu
fi

