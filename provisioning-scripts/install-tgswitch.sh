#!/usr/bin/env bash

curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | bash

TERRAGRUNT_TF12=0.25.0
TERRAGRUNT_TF11=0.18.7
TGSWITCH=/usr/local/bin/tgswitch

chmod 555 $HOME

$TGSWITCH $TERRAGRUNT_TF12
$TGSWITCH $TERRAGRUNT_TF11

chmod 555 $HOME/.terragrunt.versions