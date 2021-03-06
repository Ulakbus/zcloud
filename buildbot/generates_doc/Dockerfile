FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   libffi-dev \
   libssl-dev \
   git \
   wget \
   graphviz \
   expect \
   libtiff5-dev \
   libjpeg8-dev \
   zlib1g-dev \
   libfreetype6-dev \
   liblcms2-dev \
   libwebp-dev \
   tcl8.6-dev \
   tk8.6-dev \
   python-tk
RUN pip install twisted==15.2.1 buildbot-slave requests sphinx sphinxcontrib-plantuml sphinxcontrib-images sphinxjp.themes.bizstyle sphinx_rtd_theme
RUN pip install --upgrade sphinx
RUN easy_install --upgrade six
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
RUN mkdir /opt/plantuml && wget http://heanet.dl.sourceforge.net/project/plantuml/plantuml.jar && mv plantuml.jar /opt/plantuml/
RUN echo 'buildbot ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN mkdir /home/buildbot && chown buildbot:buildbot /home/buildbot
RUN chown -R buildbot:buildbot /usr/local/
USER buildbot
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Buildbot of ZetaOps"
RUN git config --global push.default upstream
WORKDIR /buildslave
ENV PYOKO_SETTINGS ulakbus.settings
COPY clone.sh /buildslave/
COPY doc_generate.sh /buildslave/
COPY unite_docs.sh /buildslave/
COPY git_push_with_expect.sh /buildslave/
RUN chown buildbot:buildbot /buildslave/clone.sh
RUN chown buildbot:buildbot /buildslave/doc_generate.sh
RUN chown buildbot:buildbot /buildslave/unite_docs.sh
RUN chown buildbot:buildbot /buildslave/git_push_with_expect.sh
RUN chmod +x /buildslave/clone.sh
RUN chmod +x /buildslave/doc_generate.sh
RUN chmod +x /buildslave/unite_docs.sh
RUN chmod +x /buildslave/git_push_with_expect.sh
COPY buildbot.tac /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]