#!/usr/bin/env bash

curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

TERRAFORM_11=0.11.14
TERRAFORM_12=0.13.3
TFSWITCH=/usr/local/bin/tfswitch

chmod 555 $HOME

$TFSWITCH $TERRAFORM_11
$TFSWITCH $TERRAFORM_12

chmod 555 $HOME/.terraform.versions