FROM zetaops/zops-pypy3-git
MAINTAINER Ali Riza Keles Cem Guresci, alirza@zetaops.io


# libssl and libffi dev packages for riak client
RUN apt-get update && apt-get install -y --no-install-recommends libssl-dev libffi-dev gcc
RUN apt-get update && apt-get install -y --no-install-recommends libfreetype6-dev libxml2-dev libxslt1-dev python-dev libtiff5-dev zlib1g-dev libjbig0 libjpeg62-turbo liblcms2-2 \
              libtiff5 libwebp5 libwebpdemux1 libwebpmux1 libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk


RUN apt-get purge -y gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# create app directory and clone zaerp master
RUN mkdir /app
WORKDIR /app

### Clone ulakbus from github ###
RUN git clone https://github.com/ulakbus/zengine.git

### Run setup.py ###
WORKDIR /app/ulakbus/

RUN pypy3 setup.py install

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

WORKDIR /app/ulakbus/gunicorn
CMD ["gunicorn server:app -c gunicorn_config.py"]
