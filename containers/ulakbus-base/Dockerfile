FROM python:2-slim
MAINTAINER Ali Riza Keles Cem Guresci, alirza@zetaops.io

# libssl and libffi dev packages for riak client
RUN apt-get update && apt-get install -y --no-install-recommends git libssl-dev \
    libffi-dev gcc build-essential libfreetype6-dev libxml2-dev libxslt1-dev \
    python-dev libtiff5-dev zlib1g-dev libjbig0 libjpeg62-turbo liblcms2-2 \
    libtiff5 libwebp5 libwebpdemux1 libwebpmux1 libfreetype6-dev liblcms2-dev \
    libwebp-dev tcl8.6-dev tk8.6-dev python-tk


# create app directory and clone zaerp master
RUN mkdir /app
WORKDIR /app

RUN sed -i "1s/^/import sys \nsys.setdefaultencoding('utf-8') \n /" /etc/python2.7/sitecustomize.py
RUN ln -s /etc/python2.7/sitecustomize.py /usr/local/lib/python2.7/sitecustomize.py

### Clone ulakbus from github ###
RUN git clone https://github.com/zetaops/ulakbus.git

### Run setup.py ###
WORKDIR /app/ulakbus/
