#!/usr/bin/env bash

APPLICATION=go
VERSION=1.9.3
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

OLD_PATH=$(grep 'Defaults\s*secure_path\s*=\s*\(.*\)' /etc/sudoers |
awk -F'=' '{print $2}' |
sed -e 's/^[ \t]*//')
OLD_SECURE_PATH="Defaults    secure_path = $OLD_PATH"
NEW_SECURE_PATH="Defaults    secure_path = $OLD_PATH:$GOROOT/bin:$GOPATH/bin"

sed -i "s|$OLD_SECURE_PATH|$NEW_SECURE_PATH|" /etc/sudoers

echo 'Defaults    env_keep += "GOPATH"' >> /etc/sudoers.d/go

mkdir -p $GOPATH/{src,bin,pkg}

go get -u golang.org/x/tools/cmd/...
go get -u github.com/golang/lint/golint

chown -R root:wheel $GOPATH
chmod -R 775 $GOPATH/{src,bin,pkg}
