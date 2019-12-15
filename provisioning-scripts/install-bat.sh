#!/usr/bin/env bash

CENTOS_VERSION=$(rpm -E %{rhel})

if [[ $CENTOS_VERSION -gt 6 ]]; then
    yum install -y clang

    # https://github.com/sharkdp/bat
    cd /tmp
    git clone https://github.com/sharkdp/bat.git
    cd /tmp/bat

    # Need to reload PATH for the current shell to access cargo
    source $HOME/.profile

    cargo build --release
    cp /tmp/bat/target/release/bat /usr/bin

    cd /root
    rm -fr /tmp/bat
else
    echo "\n[WARN] bat requires Centos 7 or higher.\n"
fi

