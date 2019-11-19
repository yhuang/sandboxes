#!/usr/bin/env bash

APPLICATION=terraform
VERSION=0.11.14
ARCHIVE=${APPLICATION}_${VERSION}_linux_amd64.zip

wget https://releases.hashicorp.com/$APPLICATION/$VERSION/$ARCHIVE

unzip $ARCHIVE -d /usr/local/bin/hashicorp
rm -f $ARCHIVE
