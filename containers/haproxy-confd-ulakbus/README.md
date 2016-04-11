HAProxy with Confd 
==================
HAProxy Confd for:

* Redis
* Riak Servers
* Rabbit
* Ulakbus Tornado and Zengine Workers
* Kibana, Unitime, Solr, etc..

Usage:

```
docker run -d -v /etc/localtime:/etc/localtime:ro --name 
    haproxy-confd-ulakbus -p 80:80 -p 443:443 -e "ETCD_IP=10.0.0.1"  
    -e "ETCD_PORT=4001"  -e "APP=ulakbus" zetaops/haproxy-confd-ulakbus
```

