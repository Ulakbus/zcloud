FROM pypy:3-slim
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# env vars for ulakbus
ENV PYTHONIOENCODING UTF-8
ENV RABBIT_SERVER zengine.settings

# libssl and libffi dev packages for riak client
RUN apt-get update && apt-get install -y --no-install-recommends build-essential
               && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

ADD app.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
