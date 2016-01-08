FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   python-sphinx \
   git \
   wget \
   graphviz
RUN pip install twisted==15.2.1 buildbot-slave requests sphinxcontrib-plantuml sphinxjp.themes.bizstyle
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
RUN git clone https://github.com/zetaops/ulakbus.git /buildslave/ulakbus
RUN git clone https://github.com/zetaops/zengine.git /buildslave/zengine
RUN git clone https://github.com/zetaops/pyoko.git /buildslave/pyoko
RUN git clone https://github.com/zetaops/ulakbus.org.git /buildslave/ulakbus.org
COPY doc_generate.sh /buildslave/
COPY unite_docs.sh /buildslave/
COPY buildbot.tac /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]