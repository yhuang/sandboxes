#!/usr/bin/env bash

source /etc/profile.d/goenv.sh
go get github.com/renier/hcl2json
go get github.com/palantir/tfjson

chmod a+x /etc/opt/go/bin/hcl2json
chmod a+x /etc/opt/go/bin/tfjson
