FROM python:2.7-slim
MAINTAINER Ali Riza Keles, alirza@zetaops.io

# env vars for ulakbus
ENV PYTHONIOENCODING UTF-8
ENV ZENGINE_SETTINGS ulakbus.settings
ENV LC_CTYPE en_US.UTF-8
ENV PYOKO_SETTINGS ulakbus.settings
ENV PYTHONUNBUFFERED 1

# defaults, will be overridden by run script, -e RIAK_SERVER=RIAK_LB
ENV RIAK_PORT 8098
ENV REDIS_SERVER 127.0.0.1:6379
ENV RIAK_SERVER 127.0.0.1
ENV RIAK_PROTOCOL http
ENV ALLOWED_ORIGINS http://nightly.ulakbus.net

ENV S3_PROXY_URL ulakbus-internal-riakcs.zetaops.local
ENV S3_PUBLIC_URL http://ulakbus.3s.ulakbus.net/
ENV S3_PROXY_PORT 8080
ENV S3_BUCKET_NAME ulakbus

# libssl and libffi dev packages for riak client
RUN apt-get update && apt-get install -y --no-install-recommends git libssl-dev libffi-dev gcc
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libfreetype6-dev python-dev libtiff5-dev zlib1g-dev libjbig0 libjpeg62-turbo liblcms2-2 libtiff5 libwebp5 libwebpdemux1 libwebpmux1 libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
RUN pip install cryptography \
    && pip install gunicorn gevent \
    && pip install reportlab

RUN apt-get purge -y gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# change default encoding
RUN sed -i "s/encoding = \"ascii\"/encoding = \"utf-8\"/" /usr/local/lib/python2.7/site.py

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

ADD app.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]