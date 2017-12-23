#!/usr/bin/env bash

VERSION=1.9.2

cat > /etc/profile.d/goenv.sh << GOENV_SH
export GOROOT=/opt/go
export GOPATH=/etc/opt/go
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
GOENV_SH

wget https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz
tar -C /opt -xzf go${VERSION}.linux-amd64.tar.gz
rm go${VERSION}.linux-amd64.tar.gz

chmod a+x /etc/profile.d/goenv.sh
source /etc/profile.d/goenv.sh

go get -u golang.org/x/tools/cmd/...
go get -u github.com/golang/lint
go get -u github.com/nsf/gocode
