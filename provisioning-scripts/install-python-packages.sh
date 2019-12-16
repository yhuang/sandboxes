#!/usr/bin/env bash

if hash python3 2>/dev/null; then
    python3 -m pip install --upgrade pip
    python3 -m pip install --upgrade six
    python3 -m pip install --upgrade google-api-python-client
    python3 -m pip install --upgrade oauth2client
    python3 -m pip install requests
    # https://github.com/pypa/pip/issues/3165
    python3 -m pip install --ignore-installed google-cloud-storage
    python3 -m pip install google-auth
    python3 -m pip install lxml
fi

pip2 install --upgrade pip
pip2 install --upgrade six
pip2 install --upgrade google-api-python-client
pip2 install --upgrade oauth2client
pip2 install requests
# https://github.com/pypa/pip/issues/3165
pip2 install --ignore-installed google-cloud-storage
pip2 install google-auth
pip2 install lxml
