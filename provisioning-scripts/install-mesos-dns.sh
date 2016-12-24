#!/usr/bin/env bash

yum install -y golang bind-utils

export GOPATH=/usr/local/lib/go

GOBINPATH=$GOPATH/bin
export PATH=$PATH:$GOBINPATH

mkdir -p $GOPATH
echo "pathmunge $GOBINPATH after" > /etc/profile.d/go.sh
chmod a+x /etc/profile.d/go.sh

go get github.com/tools/godep
go get github.com/mesosphere/mesos-dns

CURRENT_DIR=$(pwd)
cd $GOPATH/src/github.com/mesosphere/mesos-dns
godep go build .
cd $CURRENT_DIR
