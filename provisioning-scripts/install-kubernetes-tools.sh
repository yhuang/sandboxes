#!/usr/bin/env bash

# Bug 1792506 - Unattended installation of repo GPG keys is failing
# https://bugzilla.redhat.com/show_bug.cgi?id=1792506
#
# Fix: https://access.redhat.com/errata/RHBA-2020:1823
cat > /etc/yum.repos.d/kubernetes.repo << EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
# gpgcheck=1
# repo_gpgcheck=1
# gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
#        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

rpm --import https://packages.cloud.google.com/yum/doc/yum-key.gpg
rpm --import https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg

yum install -y kubectl

curl -s https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod a+x skaffold
mv skaffold /usr/local/bin

VERSION=3.3.0

curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases |\
  grep browser_download |\
  grep linux |\
  grep $VERSION |\
  cut -d '"' -f 4 |\
  xargs curl -O -L
tar xzvf kustomize_*_linux_amd64.tar.gz
rm -f kustomize_*_linux_amd64.tar.gz
mv kustomize /usr/local/bin/kustomize
chmod a+x /usr/local/bin/kustomize

git clone https://github.com/ahmetb/kubectx /opt/kubectx
chmod a+x /usr/local/bin/*
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
