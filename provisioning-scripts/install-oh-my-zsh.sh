#!/usr/bin/env bash

INSTALL_SH=/tmp/install-oh-my-zsh.sh
chmod a+x $INSTALL_SH
$INSTALL_SH || echo "$INSTALL_SH exit code $? is suppressed."
