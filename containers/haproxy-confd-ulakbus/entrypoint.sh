#!/bin/bash

set -e

mkdir -p ~/etc/confd/templates/
echo templates folder has been created.
mkdir -p ~/etc/confd/conf.d/
echo conf.d folder has been created.

cp /data/$APP/haproxy.cfg /etc/confd/templates/haproxy.cfg
cp /data/$APP/haproxy.toml /etc/confd/conf.d/haproxy.toml
cp /data/$APP/configuration.toml /etc/confd/confd.toml

if [ "$APP" == "ulakbus" ]; then
    mkdir -p /usr/local/etc/ssl
	echo "" > /usr/local/etc/ssl/ulakbus.net.pem
    echo "" > /usr/local/etc/ssl/ulakbus.net.ca
    echo "" > /usr/local/etc/ssl/ulakbus.net.crt
    echo "" > /usr/local/etc/ssl/ulakbus.net.key

    cp /data/ulakbus/ssl_ca.cfg /etc/confd/templates/ssl_ca.cfg
	cp /data/ulakbus/ssl_ca.toml /etc/confd/conf.d/ssl_ca.toml

	cp /data/haproxy-confd-ulakbus/ssl_crt.cfg ~/etc/confd/templates/ssl_crt.cfg
    cp /data/haproxy-confd-ulakbus/ssl_crt.toml ~/etc/confd/conf.d/ssl_crt.toml

	cp /data/haproxy-confd-ulakbus/ssl_key.cfg ~/etc/confd/templates/ssl_key.cfg
    cp /data/haproxy-confd-ulakbus/ssl_key.toml ~/etc/confd/conf.d/ssl_key.toml

	cp /data/haproxy-confd-ulakbus/ssl_pem.cfg ~/etc/confd/templates/ssl_pem.cfg
    cp /data/haproxy-confd-ulakbus/ssl_pem.toml ~/etc/confd/conf.d/ssl_pem.toml

fi

exec gosu root confd -backend etcd -node $ETCD_HOST:$ETCD_PORT
