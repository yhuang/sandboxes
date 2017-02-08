#!/usr/bin/env bash

yum install -y yum-plugin-changelog

mv /tmp/config.toml 

source /etc/profile.d/goenv.sh

mkdir /var/log/vuls
mkdir -p $GOPATH/src/github.com/kotakanbe
cd $GOPATH/src/github.com/kotakanbe
git clone https://github.com/kotakanbe/go-cve-dictionary.git
cd go-cve-dictionary
make install

mkdir -p /etc/local/cve
for i in {2002..2016}; do
  go-cve-dictionary fetchnvd -years $i;
done

mkdir -p $GOPATH/src/github.com/future-architect
cd $GOPATH/src/github.com/future-architect
git clone https://github.com/future-architect/vuls.git
cd vuls
make install
