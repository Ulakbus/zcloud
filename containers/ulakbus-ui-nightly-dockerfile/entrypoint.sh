#!/bin/bash
git clone https://github.com/zetaops/ulakbus-ui.git /tmp/html
rm -rf  /usr/share/nginx/html
cp -rf /tmp/html/dist /usr/share/nginx/html
nginx -g 'daemon off;'
