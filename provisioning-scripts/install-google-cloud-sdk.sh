#!/usr/bin/env bash

# http://jhurani.com/linux/2018/07/30/GCSDK-on-centos6.html

CENTOS_VERSION=$(rpm --query centos-release | cut -d"-" -f3)

if [[ $CENTOS_VERSION -eq 6 ]]; then
    . /opt/rh/python27/enable
    export CLOUDSDK_PYTHON=/opt/rh/python27/root/usr/bin/python2

    sudo yumdownloader -y google-cloud-sdk
    GOOGLE_CLOUD_SDK_RPM=$(ls *google-cloud-sdk*.rpm)
    rpm -i --nodeps $GOOGLE_CLOUD_SDK_RPM
    rm -f $GOOGLE_CLOUD_SDK_RPM
else
    cat << EOF > /etc/yum.repos.d/google-cloud-sdk.repo
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

    yum install -y google-cloud-sdk
fi
