#!/usr/bin/env bash

DOCKER_CE_REPO=https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --add-repo $DOCKER_CE_REPO
yum-config-manager --disable docker-ce-nightly

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 8 ]]; then
    # https://linoxide.com/linux-how-to/how-to-install-docker-on-centos/
    dnf -y  install docker-ce --nobest
    systemctl enable --now docker
else
    yum install -y docker-ce

    systemctl enable docker
    systemctl start docker
fi

usermod -aG docker $USER
usermod -aG docker vagrant