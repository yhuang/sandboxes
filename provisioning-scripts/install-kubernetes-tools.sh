#!/usr/bin/env bash

cat << EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

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
mv kustomize /usr/local/bin/kustomize
chmod a+x /usr/local/bin/kustomize

git clone https://github.com/ahmetb/kubectx /opt/kubectx
chmod a+x /usr/local/bin/*
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
