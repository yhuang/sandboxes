#!/usr/bin/env bash

curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

TERRAFORM_11=0.11.14
TERRAFORM_12=0.12.9
TFSWITCH=/usr/local/bin/tfswitch

$TFSWITCH $TERRAFORM_11
$TFSWITCH $TERRAFORM_12