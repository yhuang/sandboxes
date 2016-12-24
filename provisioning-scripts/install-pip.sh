#!/usr/bin/env bash

GET_PIP=/root/get-pip.py

wget -O $GET_PIP https://bootstrap.pypa.io/get-pip.py

if hash python3 2>/dev/null; then
    python3 $GET_PIP
fi

python $GET_PIP

rm -f $GET_PIP
