#!/usr/bin/env #!/usr/bin/env bash

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubectl

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/get-helm.sh
chmod a+x /tmp/get-helm.sh
/tmp/get-helm.sh
rm -f /tmp/get-helm.sh

curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod a+x skaffold
mv skaffold /usr/local/bin

curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest |\
  grep browser_download |\
  grep linux |\
  cut -d '"' -f 4 |\
  xargs curl -O -L
mv kustomize_*_linux_amd64 /usr/local/bin/kustomize
chmod a+x /usr/local/bin/kustomize

git clone https://github.com/ahmetb/kubectx /opt/kubectx
chmod a+x /usr/local/bin/*
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
