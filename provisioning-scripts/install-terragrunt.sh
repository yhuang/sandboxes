#!/usr/bin/env bash

APPLICATION=terragrunt
VERSION=0.14.0
BINARY=${APPLICATION}_linux_amd64

wget https://github.com/gruntwork-io/$APPLICATION/releases/download/v$VERSION/$BINARY
chmod a+x $BINARY
mv $BINARY /usr/local/bin/$APPLICATION
