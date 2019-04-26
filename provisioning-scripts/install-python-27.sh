#!/usr/bin/env bash

CENTOS_VERSION=$(rpm --query centos-release | cut -d"-" -f3)

if [[ $CENTOS_VERSION -eq 6 ]]; then
    yum install -y centos-release-scl
    yum --enablerepo=centos-sclo-sclo install -y python27
fi
