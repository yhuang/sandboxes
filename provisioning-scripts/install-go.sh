#!/usr/bin/env bash

mv /tmp/goenv.sh /etc/profile.d/goenv.sh

VERSION=1.7.5

wget https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz
tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz
rm go${VERSION}.linux-amd64.tar.gz
