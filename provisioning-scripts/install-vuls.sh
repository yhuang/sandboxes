#!/usr/bin/env bash

yum install -y yum-plugin-changelog

source /etc/profile.d/goenv.sh

mkdir -p /var/log/vuls
mkdir -p $GOPATH/src/github.com/kotakanbe
cd $GOPATH/src/github.com/kotakanbe
git clone https://github.com/kotakanbe/go-cve-dictionary.git
cd go-cve-dictionary
make install

mkdir -p /etc/opt/cve
for i in {2002..2016}; do
  go-cve-dictionary fetchnvd -years $i;
done

mkdir -p $GOPATH/src/github.com/future-architect
cd $GOPATH/src/github.com/future-architect
git clone https://github.com/future-architect/vuls.git
cd vuls
make install

mkdir -p /etc/opt/vuls
cat > /etc/opt/vuls/config.toml << CONFIG_TOML
[servers]

[servers.localhost]
host         = "localhost" # or "127.0.0.1"
port         = "local"
CONFIG_TOML

OLD_PATH="Defaults\s*secure_path\s*=\s*.*"
NEW_PATH='Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/etc/opt/go/bin'
sed -i "s|$OLD_PATH|$NEW_PATH|" /etc/sudoers
