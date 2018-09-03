#!/usr/bin/env bash

# https://github.com/sharkdp/bat
cd /tmp
git clone https://github.com/sharkdp/bat.git
cd /tmp/bat

cargo build --release
cp /tmp/bat/target/release/bat /usr/bin

cd /root
rm -fr /tmp/bat
