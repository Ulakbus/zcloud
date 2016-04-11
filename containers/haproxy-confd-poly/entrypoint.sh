#!/bin/bash

set -e
#exec gosu root confd -backend etcd -node $ETCD_IP:4001

mkdir -p ~/etc/confd/templates/
echo templates folder has been created.
mkdir -p ~/etc/confd/conf.d/
echo conf.d folder has been created.


case $OPTION in
    elk)
        cp /data/haproxy-confd-elk/haproxy.cfg ~/etc/confd/templates/haproxy.cfg
        echo elk haproxy.cfg has been copied.
	cp /data/haproxy-confd-elk/haproxy.toml ~/etc/confd/conf.d/haproxy.toml
        echo elk haproxy.toml has been copied.
	cp /data/haproxy-confd-elk/configuration.toml ~/etc/confd/confd.toml
        echo elk confd.toml has been copied.
	 ;;
    redis)
        cp /data/haproxy-confd-redis/haproxy.cfg ~/etc/confd/templates/haproxy.cfg
        echo redis haproxy.cfg has been copied.
	cp /data/haproxy-confd-redis/haproxy.toml ~/etc/confd/conf.d/haproxy.toml
        echo redis haproxy.toml has been copied.
	cp /data/haproxy-confd-redis/configuration.toml ~/etc/confd/confd.toml
        echo redis confd.toml has been copied.
	;;
    riak)
        cp /data/haproxy-confd-riak/haproxy.cfg ~/etc/confd/templates/haproxy.cfg
	echo riak haproxy.cfg has been copied.
        cp /data/haproxy-confd-riak/haproxy.toml ~/etc/confd/conf.d/haproxy.toml
        echo riak haproxy.toml has been copied.
	cp /data/haproxy-confd-riak/configuration.toml ~/etc/confd/confd.toml
        echo riak confd.toml has been copied.
	;;
    ulakbus)
        cp /data/haproxy-confd-ulakbus/zhaproxy.cfg ~/etc/confd/templates/zhaproxy.cfg
	echo ulakbus zhaproxy.cfg has been copied.
        cp /data/haproxy-confd-ulakbus/zhaproxy.toml ~/etc/confd/conf.d/zhaproxy.toml
	echo ulakbus zhaproxy.toml has been copied.
	cp /data/haproxy-confd-ulakbus/ssl_ca.cfg ~/etc/confd/templates/ssl_ca.cfg
        echo ulakbus ssl_ca.cfg has been copied.
	cp /data/haproxy-confd-ulakbus/ssl_ca.toml ~/etc/confd/conf.d/ssl_ca.toml
	echo ulakbus ssl_ca.toml has been copied.

        mkdir -p /usr/local/etc/ssl
	echo ulakbus ssl folder has been created.
        echo "" > /usr/local/etc/ssl/ulakbus.net.pem
        echo "" > /usr/local/etc/ssl/ulakbus.net.ca
        echo "" > /usr/local/etc/ssl/ulakbus.net.crt
        echo "" > /usr/local/etc/ssl/ulakbus.net.key

        cp /data/haproxy-confd-ulakbus/ssl_crt.cfg ~/etc/confd/templates/ssl_crt.cfg
        cp /data/haproxy-confd-ulakbus/ssl_crt.toml ~/etc/confd/conf.d/ssl_crt.toml
	echo ulakbus ssl_crt.cfg and ssl_crt.toml has been copied.
        cp /data/haproxy-confd-ulakbus/ssl_key.cfg ~/etc/confd/templates/ssl_key.cfg
        cp /data/haproxy-confd-ulakbus/ssl_key.toml ~/etc/confd/conf.d/ssl_key.toml
	echo ulakbus ssl_key.cfg and ssl_key.toml has been copied.
        cp /data/haproxy-confd-ulakbus/ssl_pem.cfg ~/etc/confd/templates/ssl_pem.cfg
        cp /data/haproxy-confd-ulakbus/ssl_pem.toml ~/etc/confd/conf.d/ssl_pem.toml
	echo ulakbus ssl_pem.cfg and ssl_pem.toml has been copied.
        cp /data/haproxy-confd-ulakbus/configuration.toml ~/etc/confd/confd.toml
	echo ulakbus confd.toml has been copied.
        exit 1
	;;
    *)
        echo "Unknown operation, type one of them: elk|redis|riak|ulakbus"
esac
