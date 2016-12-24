#!/usr/bin/env bash

yum install -y yum-utils

yum install -y epel-release
yum-config-manager --disable epel
