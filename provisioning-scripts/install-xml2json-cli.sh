#!/usr/bin/env bash

# https://www.npmjs.com/package/xml2json-cli

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -gt 6 ]]; then
    # https://stackoverflow.com/questions/21855035/ssl-error-cert-untrusted-while-using-npm-command
    npm install --global --unsafe-perm xml2json-cli
else
    echo "\n[WARN] xml2json-cli requires Centos 7 or higher.\n"
fi