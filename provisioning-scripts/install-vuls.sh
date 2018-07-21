#!/usr/bin/env bash

START=2002
END=$(date +"%Y")

yum install -y yum-plugin-changelog

source /etc/profile.d/goenv.sh

mkdir -p /var/log/vuls
mkdir -p $GOPATH/src/github.com/kotakanbe
cd $GOPATH/src/github.com/kotakanbe
git clone https://github.com/kotakanbe/go-cve-dictionary.git
cd go-cve-dictionary
make install

CVE_DIR=/etc/opt/cve
mkdir -p $CVE_DIR
cd $CVE_DIR
for i in $(seq $START $END); do
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
