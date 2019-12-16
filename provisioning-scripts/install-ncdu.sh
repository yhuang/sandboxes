#!/usr/bin/env bash

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 6 ]]; then
    # https://centos.pkgs.org/6/openfusion-x86_64/ncdu-1.7-1.of.el6.x86_64.rpm.html
    wget http://repo.openfusion.net/centos6-x86_64/openfusion-release-0.7-1.of.el6.noarch.rpm
    rpm -Uvh openfusion-release*rpm
    yum install -y ncdu
    rm -f openfusion-release*rpm
else
    # https://software.opensuse.org//download.html?project=utilities&package=ncdu
    curl https://download.opensuse.org/repositories/utilities/RHEL_7/utilities.repo -o /etc/yum.repos.d/utilities.repo
    yum install -y ncdu
fi

