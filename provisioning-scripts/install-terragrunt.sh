#!/usr/bin/env bash

APPLICATION=terragrunt

# 0.17.4 is available, but the executable has not been compiled.
VERSION=0.17.3
BINARY=${APPLICATION}_linux_amd64

wget https://github.com/gruntwork-io/$APPLICATION/releases/download/v$VERSION/$BINARY
chmod a+x $BINARY
mv $BINARY /usr/local/bin/$APPLICATION
