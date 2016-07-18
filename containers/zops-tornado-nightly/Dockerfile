FROM pypy:3-slim
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# env vars for ulakbus
ENV PYTHONIOENCODING UTF-8

# libssl and libffi dev packages for riak client
RUN apt-get update && apt-get install -y --no-install-recommends build-essential
RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# create app directory and clone zaerp master
RUN mkdir /app
WORKDIR /app

### Clone ulakbus from github ###
RUN git clone https://github.com/zetaops/zengine.git

### Run setup.py ###
WORKDIR /app/zengine/

RUN pypy3 setup.py install

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

CMD ["pypy3" "/app/zengine/zengine/tornado_server/server.py"]
