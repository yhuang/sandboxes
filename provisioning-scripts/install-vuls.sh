#!/usr/bin/env bash

UP_TO_YEAR=2016

yum install -y yum-plugin-changelog

source /etc/profile.d/goenv.sh

mkdir /var/log/vuls
mkdir -p $GOPATH/src/github.com/kotakanbe
cd $GOPATH/src/github.com/kotakanbe
git clone https://github.com/kotakanbe/go-cve-dictionary.git
cd go-cve-dictionary
make install

mkdir -p /etc/opt/cve
for i in {2002..$UP_TO_YEAR}; do
  go-cve-dictionary fetchnvd -years $i;
done

mkdir -p $GOPATH/src/github.com/future-architect
cd $GOPATH/src/github.com/future-architect
git clone https://github.com/future-architect/vuls.git
cd vuls
make install

mkdir -p /etc/opt/vuls
mv /tmp/config.toml /etc/opt/vuls

OLD_PATH="Defaults\s*secure_path\s*=\s*.*"
NEW_PATH='Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/etc/opt/go'
sed "s|$OLD_PATH|$NEW_PATH|" /etc/sudoers
