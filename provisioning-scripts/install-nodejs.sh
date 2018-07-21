#!/usr/bin/env bash

yum install -y http-parser
yum --disablerepo="*" --enablerepo="epel" install -y nodejs
