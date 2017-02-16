#!/usr/bin/env bash

# Update YUM with Cloud SDK repo information:
tee -a /etc/yum.repos.d/google-cloud-sdk.repo<<EOF
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# The indentation for the 2nd line of <code>gpgkey</code> is important.

# Install the Cloud SDK
yum install -y google-cloud-sdk
