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

pip install --upgrade pip
pip install --upgrade six
pip install --upgrade google-api-python-client
pip install --upgrade oauth2client
pip install requests
# https://github.com/pypa/pip/issues/3165
pip install --ignore-installed google-cloud-storage
pip install google-auth
pip install lxml
