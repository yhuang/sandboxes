#!/usr/bin/env bash

curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | bash

TERRAGRUNT_TF12=0.23.13
TERRAGRUNT_TF11=0.17.3
TGSWITCH=/usr/local/bin/tgswitch

$TGSWITCH $TERRAGRUNT_TF12
$TGSWITCH $TERRAGRUNT_TF11