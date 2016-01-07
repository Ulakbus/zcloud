FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   git
RUN pip install twisted==15.2.1 buildbot-slave requests docker-py
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
RUN echo 'buildbot ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave
RUN mkdir /home/buildbot && chown buildbot:buildbot /home/buildbot
RUN chown -R buildbot:buildbot /usr/local/
USER buildbot
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Buildbot of ZetaOps"
RUN git config --global push.default matching
WORKDIR /buildslave
COPY vagrant_builder.py /buildslave/
COPY buildbot.tac /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]