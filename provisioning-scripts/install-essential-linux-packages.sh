#!/usr/bin/env bash

yum install -y \
bind-utils \
cmake \
dstat \
gettext-devel \
http-parser \
iftop \
iotop \
iptraf \
lsof \
nmap \
nmap-ncat \
openssl-devel \
patch \
perl-CPAN \
perl-devel \
python-devel \
python-requests \
python-setuptools \
sysstat \
tcpdump \
texinfo \
telnet \
traceroute \
yum-utils \
zlib-devel \
zsh

yum install -y epel-release
yum-config-manager --disable epel

yum --disablerepo="*" --enablerepo="epel" install -y \
asciinema \
htop \
jq \
nodejs \
python36
