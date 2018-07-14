#!/usr/bin/env bash

curl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -o /usr/local/bin/cfssl
curl https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -o /usr/local/bin/cfssljson
chmod a+x /usr/local/bin/cfssl /usr/local/bin/cfssljson
