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

CENTOS_VERSION=$(rpm --query centos-release | cut -d"-" -f3)

if [[ $CENTOS_VERSION -eq 6 ]]; then
    PYTHON_PACKAGE=python34
    PYTHON=python3.4
else
    PYTHON_PACKAGE=python36
    PYTHON=python3.6
fi

yum --disablerepo="*" --enablerepo="epel" install -y \
htop \
jq \
node \
js \
$PYTHON_PACKAGE

ln -s /usr/bin/$PYTHON /usr/bin/python3
