FROM zetaops/haproxy-conf.d 

ADD haproxy-confd-elk /data/haproxy-confd-elk
ADD haproxy-confd-redis /data/haproxy-confd-redis
ADD haproxy-confd-riak /data/haproxy-confd-riak
ADD haproxy-confd-ulakbus /data/haproxy-confd-ulakbus

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
