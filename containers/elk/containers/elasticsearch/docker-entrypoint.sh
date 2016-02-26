#!/bin/bash

set -e

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	# Change the ownership of /usr/share/elasticsearch/data to elasticsearch
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
	
	set -- gosu elasticsearch "$@"
	#exec gosu elasticsearch "$BASH_SOURCE" "$@"
fi


cat /usr/share/elasticsearch/config/elasticsearch.yml | sed "s/ES_NODE_2/$ES_NODE_2/" > /usr/share/elasticsearch/config/elasticsearch.yml.tmp
cat /usr/share/elasticsearch/config/elasticsearch.yml.tmp > /usr/share/elasticsearch/config/elasticsearch.yml 
rm /usr/share/elasticsearch/config/elasticsearch.yml.tmp

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
