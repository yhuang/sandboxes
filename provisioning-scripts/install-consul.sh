#!/usr/bin/env bash

APPLICATION=consul
VERSION=1.9.1
ARCHIVE=${APPLICATION}_${VERSION}_linux_amd64.zip

wget https://releases.hashicorp.com/$APPLICATION/$VERSION/$ARCHIVE

unzip $ARCHIVE -d /usr/local/bin/hashicorp
rm -f $ARCHIVE

mkdir -p /etc/consul.d
mkdir -p /mnt/consul
