#!/usr/bin/env bash

# https://github.com/sharkdp/fd
cd /tmp
git clone https://github.com/sharkdp/fd.git
cd /tmp/fd

cargo build --release
cp /tmp/fd/target/release/fd /usr/bin

cd /root
rm -fr /tmp/fd
