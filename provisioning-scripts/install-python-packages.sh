#!/usr/bin/env bash

if hash python3 2>/dev/null; then
    python3 -m pip install --upgrade google-api-python-client
    python3 -m pip install --upgrade oauth2client
fi

pip install --upgrade google-api-python-client
pip install --upgrade oauth2client
