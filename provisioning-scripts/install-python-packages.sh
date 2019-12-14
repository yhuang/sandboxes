#!/usr/bin/env bash

if hash python3 2>/dev/null; then
    pip3 install --upgrade pip
    pip3 install --upgrade six
    pip3 install --upgrade google-api-python-client
    pip3 install install --upgrade oauth2client
    pip3 install install requests
    # https://github.com/pypa/pip/issues/3165
    pip3 install --ignore-installed google-cloud-storage
    pip3 install google-auth
    pip3 install lxml
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
