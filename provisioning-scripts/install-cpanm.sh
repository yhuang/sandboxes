#!/usr/bin/env bash

CPANM=/usr/local/bin/cpanm

curl -L http://cpanmin.us | perl - --sudo App::cpanminus

$CPANM App::pod2pdf
$CPANM IO::Pty 

# https://beyondgrep.com/install
$CPANM App::Ack --force
