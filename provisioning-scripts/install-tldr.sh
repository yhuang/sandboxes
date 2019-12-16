#!/usr/bin/env bash

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -eq 6 ]]; then
    npm config set strict-ssl false
fi

# https://tldr.sh/
npm install -g tldr
