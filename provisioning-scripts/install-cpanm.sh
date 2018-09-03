#!/usr/bin/env bash

curl -L http://cpanmin.us | perl - --sudo App::cpanminus

/usr/local/bin/cpanm App::pod2pdf
