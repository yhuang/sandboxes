#!/usr/bin/env bash

VERSION=1.7.5

wget https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz
tar -C /opt -xzf go${VERSION}.linux-amd64.tar.gz
rm go${VERSION}.linux-amd64.tar.gz

mv /tmp/goenv.sh /etc/profile.d/goenv.sh
chmod a+x /etc/profile.d/goenv.sh
