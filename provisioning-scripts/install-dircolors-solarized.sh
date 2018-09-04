#!/usr/bin/env bash

# https://github.com/yhuang/dircolors-solarized
ETC_DIRCOLORS=/etc/dircolors

git clone https://github.com/yhuang/dircolors-solarized
mkdir -p $ETC_DIRCOLORS
cp dircolors-solarized/dircolors.ansi-universal $ETC_DIRCOLORS/ansi-universal
rm -fr dircolors-solarized
