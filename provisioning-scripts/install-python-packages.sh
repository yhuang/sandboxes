#!/usr/bin/env bash

if hash python3 2>/dev/null; then
    python3 -m pip install --upgrade google-api-python-client
    python3 -m pip install --upgrade oauth2client
    python3 -m pip install requests
    python3 -m pip install google-cloud-storage
    python3 -m pip install google-auth
fi

pip install --upgrade google-api-python-client
pip install --upgrade oauth2client
pip install requests
pip install google-cloud-storage
pip install google-auth
