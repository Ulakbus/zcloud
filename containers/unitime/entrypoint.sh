#!/bin/bash
sed -i 's/localhost:3306/$MYSQL_SERVER_PORT/' /usr/local/tomcat/conf/catalina.properties
exec /usr/local/tomcat/bin/catalina.sh run
