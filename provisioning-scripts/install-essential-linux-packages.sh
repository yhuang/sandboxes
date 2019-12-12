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
else
    if [[ $CENTOS_VERSION -eq 6 ]]; then
        PYTHON_PACKAGE=python34
        PYTHON=python3.4
    elif [[ $CENTOS_VERSION -eq 7 ]]; then
        PYTHON_PACKAGE=python36
        PYTHON=python3.6
    fi

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
    $PYTHON_PACKAGE

    rm -f /usr/bin/python3
    ln -s /usr/bin/$PYTHON /usr/bin/python3

    GET_PIP=/root/get-pip.py

    wget -O $GET_PIP https://bootstrap.pypa.io/get-pip.py

    if hash python3 2>/dev/null; then
        python3 $GET_PIP
    fi

    python $GET_PIP

    rm -f $GET_PIP
fi
