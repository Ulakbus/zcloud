#!/bin/sh
set -e

# Render config file
cat filebeat.yml | sed "s/LOGSTASH_HOST1/$LOGSTASH_HOST1/" | sed "s/LOGSTASHPORT1/$LOGSTASHPORT1/" | sed "s/LOGSTASH_HOST2/$LOGSTASH_HOST2/" | sed "s/LOGSTASHPORT2/$LOGSTASHPORT2/" | sed "s/INDEX/$INDEX/" > filebeat.yml.tmp
cat filebeat.yml.tmp > filebeat.yml
rm filebeat.yml.tmp

exec "$@"
