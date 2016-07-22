#!/bin/bash
for VAR in MYSQL_SERVER_PORT MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD;
  do
    sed -i "s/$VAR/${!VAR}/" /usr/local/tomcat/conf/unitime.properties
  done

exec /usr/local/tomcat/bin/catalina.sh run
