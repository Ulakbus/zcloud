FROM pypy:2-slim
MAINTAINER Ali Riza Keles Cem Guresci, alirza@zetaops.io

# env vars for ulakbus
ENV PYTHONIOENCODING UTF-8

# libssl and libffi dev packages for riak client
RUN apt-get update && apt-get install -y --no-install-recommends build-essential
RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
