#!/usr/bin/env bash

rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-2.noarch.rpm
yum install -y chronos marathon mesos
