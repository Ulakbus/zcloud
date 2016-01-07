FROM phusion/baseimage:0.9.17
RUN apt-get update && apt-get install -y \
   python-dev \
   python-pip \
   git \
   wget \
   unzip
RUN wget -q -O /packer.zip "https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_freebsd_amd64.zip" && unzip /packer.zip -d /bin
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
RUN alias push_vagrantbox='curl "https://atlas.hashicorp.com/ui/tutorial/check?access_token=$ATLAS_TOKEN" && ~/Applications/packer_0.8.6_darwin_amd64/packer push -name zetaops/ulakbus /buildslave/sourcefiles/template.json'
WORKDIR /buildslave
COPY vagrant_builder.py /buildslave/
COPY buildbot.tac /buildslave/
#RUN chmod +x create && ./create
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]