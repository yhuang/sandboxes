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

    yum config-manager --set-enabled powertools
    dnf --enablerepo=powertools install -y \
    jq \
    nodejs \
    texinfo
    yum config-manager --set-disabled powertools

    ln -s /usr/bin/python3 /usr/bin/python
    ln -s /usr/bin/pip3 /usr/bin/pip
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
    libicu-devel \
    python-devel \
    python-requests \
    python-setuptools \
    redhat-rpm-config \
    texinfo

    yum --disablerepo="*" --enablerepo="epel" install -y \
    htop \
    jq \
    js \
    nodejs \
    npm \
    python-pip

    # https://tecadmin.net/install-python-3-6-on-centos/
    PYTHON_PACKAGE=Python-3.6.9
    cd /tmp
    wget https://www.python.org/ftp/python/3.6.9/$PYTHON_PACKAGE.tgz
    tar xzvf $PYTHON_PACKAGE.tgz
    cd $PYTHON_PACKAGE
    /tmp/$PYTHON_PACKAGE/configure --enable-optimizations
    make altinstall

    ln -s /usr/local/bin/python3.6 /usr/bin/python3
    ln -s /usr/local/bin/pip3.6 /usr/bin/pip3
fi
