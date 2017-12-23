#!/usr/bin/env bash

APPLICATION=go
VERSION=1.9.2
ARCHIVE=${APPLICATION}${VERSION}.linux-amd64.tar.gz

wget https://storage.googleapis.com/golang/$ARCHIVE

tar xzf $ARCHIVE -C /opt

rm -f $ARCHIVE

cat > /etc/profile.d/goenv.sh << GOENV_SH
export GOROOT=/opt/go
export GOPATH=/etc/opt/go
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
GOENV_SH

chmod a+x /etc/profile.d/goenv.sh
source /etc/profile.d/goenv.sh

mkdir -p $GOPATH/{src,bin,pkg}
chown -R root:wheel $GOPATH
chmod 775 $GOPATH/{src,bin,pkg}

go get -u golang.org/x/tools/cmd/...
go get -u github.com/golang/lint/golint
