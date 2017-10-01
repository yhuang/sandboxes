#!/usr/bin/env bash

DOCKER_CE_REPO=https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --add-repo $DOCKER_CE_REPO
yum-config-manager --disable docker-ce-edge

yum install -y docker-ce

systemctl enable docker
systemctl start docker
