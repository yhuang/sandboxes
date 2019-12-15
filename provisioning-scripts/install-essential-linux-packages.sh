#!/usr/bin/env bash

yum install -y \
bind-utils \
cmake \
dstat \
gettext-devel \
http-parser \
iotop \
iptraf \
lsof \
nmap \
nmap-ncat \
openssl-devel \
patch \
perl-CPAN \
perl-devel \
sysstat \
tcpdump \
telnet \
traceroute \
yum-utils \
zlib-devel \
zsh

yum install -y epel-release
yum-config-manager --disable epel

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 8 ]]; then
    yum install -y \
    python2 \
    python2-pip \
    python3 \
    python3-pip

    yum --disablerepo="*" --enablerepo="epel" install -y \
    iftop

    yum config-manager --set-enabled PowerTools
    dnf --enablerepo=PowerTools install -y \
    jq \
    nodejs \
    texinfo
    yum config-manager --set-disabled PowerTools
elif [[ $CENTOS_VERSION -eq 7 ]]; then
    yum install -y \
    iftop \
    python-devel \
    python-requests \
    python-setuptools \
    texinfo

    yum --disablerepo="*" --enablerepo="epel" install -y \
    htop \
    jq \
    js \
    nodejs \
    python-pip

    yum install -y https://centos7.iuscommunity.org/ius-release.rpm
    yum install -y \
    python36u \
    python36u-libs \
    python36u-devel \
    python36u-pip
else
    yum install -y \
    iftop \
    python-devel \
    python-requests \
    python-setuptools \
    texinfo

    PYTHON_PACKAGE=python34
    PYTHON=python3.4

    yum --disablerepo="*" --enablerepo="epel" install -y \
    htop \
    jq \
    js \
    nodejs \
    python-pip \
    $PYTHON_PACKAGE

    rm -f /usr/bin/python3
    ln -s /usr/bin/$PYTHON /usr/bin/python3

    if hash python3 2>/dev/null; then
        GET_PIP=/root/get-pip.py
        wget -O $GET_PIP https://bootstrap.pypa.io/get-pip.py
        python3 $GET_PIP
        rm -f $GET_PIP
    fi
fi
