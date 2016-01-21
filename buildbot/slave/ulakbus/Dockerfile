FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python3.4-dev \
   python3-setuptools \
   python-pip \
   python3-pip \
   libffi-dev \
   libssl-dev \
   git \
   libtiff5-dev \
   libjpeg8-dev \
   zlib1g-dev \
   libfreetype6-dev \
   liblcms2-dev \
   libwebp-dev \
   tcl8.6-dev \
   tk8.6-dev \
   python-tk
RUN pip install twisted==15.2.1 buildbot-slave pytest
RUN pip3 install pytest
RUN easy_install --upgrade six
RUN easy_install3 --upgrade six
RUN sed -i "s/encoding = \"ascii\"/encoding = \"utf-8\"/" /usr/lib/python2.7/site.py
RUN sed -i "s/encoding = \"ascii\"/encoding = \"utf-8\"/" /usr/lib/python3.4/site.py
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
# RUN sed -Ei 's/(\%buildbot ALL=\(ALL\) )ALL/\1 NOPASSWD:ALL/' /etc/sudoers
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN chown -R buildbot:buildbot /usr/local/
# Install your build-dependencies here ...
USER buildbot
WORKDIR /buildslave

# environment variables
ENV PYTHONIOENCODING UTF-8
ENV PYOKO_SETTINGS 'ulakbus.settings'
ENV RIAK_SERVER 'ulakbus-load-balancer-02.zetaops.local'
ENV RIAK_PORT '8098'
ENV RIAK_PROTOCOL 'http'
ENV DEFAULT_BUCKET_TYPE 'buildbot_test'
ENV ZENGINE_SETTINGS 'ulakbus.settings'
ENV REDIS_SERVER 'ulakbus-load-balancer-02.zetaops.local:6379'

COPY buildbot.tac /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]