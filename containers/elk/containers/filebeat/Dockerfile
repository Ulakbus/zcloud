FROM debian:jessie

ENV FILEBEAT_VERSION 1.1.0
ENV FILEBEAT_SHA1 fecdb702870d51322816d05e0bd7292dedc10b79

RUN apt-get -y update
RUN apt-get -y install apt-transport-https
RUN apt-get -y install curl
RUN curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://packages.elastic.co/beats/apt stable main" | tee -a /etc/apt/sources.list.d/beats.list

RUN apt-get -y update
RUN apt-get -y install filebeat

ADD filebeat.yml /filebeat.yml
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/filebeat", "-e", "-v", "-c", "/filebeat.yml"]
