#!/bin/bash

set -e

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- logstash "$@"
fi

# Run as user "logstash" if the command is "logstash"
if [ "$1" = 'logstash' ]; then
	set -- gosu logstash "$@"
fi


cat /logstash_config/logstash.conf | sed "s/ES_HOST/$ES_HOST/" > /logstash_config/logstash.conf.tmp
cat /logstash_config/logstash.conf.tmp > /logstash_config/logstash.conf
rm /logstash_config/logstash.conf.tmp

exec "$@"

