#!/usr/bin/env bash

yum --disablerepo="*" --enablerepo="epel" install -y python-pip

yum install -y cairo-devel \
               libffi-devel \
               python-devel \
               httpd \
               mod_wsgi \
               memcached \
               rrdtool-devel \
               openldap-devel \
               cyrus-sasl-devel

pip install --upgrade pip

pip install cffi==1.8.3 \
            python-ldap==2.4.27 \
            rrdtool==0.1.6

pip install cairocffi==0.7.2 \
            django==1.4 \
            django-tagging==0.3.1 \
            gunicorn==19.6.0 \
            python-memcached==1.47 \
            pytz==2016.7 \
            simplejson==2.1.6 \
            sphinx==1.3.1 \
            txAMQP==0.4 \
            whisper==0.9.15

pip install graphite-web==0.9.15

pip install mocker==1.1.1 \
            twisted==16.4.1

pip install carbon==0.9.15

pip install graphite-api==1.1.3

cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf
mv /tmp/carbon.conf /opt/graphite/conf/carbon.conf

cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi
mv /tmp/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
mv /tmp/graphite.conf /etc/httpd/conf.d/graphite.conf

chmod 755 /opt/graphite/storage
chown -R apache:apache /opt/graphite
