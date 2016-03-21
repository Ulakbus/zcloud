#!/bin/bash
git clone https://github.com/zetaops/ulakbus-ui.git /tmp/html
cd /tmp/html

case $OPTION in
    ulakbus-ui)
        git checkout $(git describe --abbrev=0 --tags)
        echo ui files have been cloned
        ;;
    ulakbus-ui-nightly)

        ;;
    *)
        echo "Unknown operation, type one of them: ulakbus-ui|ulakbus-ui-nightly"

esac

rm -rf  /usr/share/nginx/html
cp -rf /tmp/html/dist /usr/share/nginx/html
echo ui-nighly files have been copied
#service nginx start
nginx -g 'daemon off;'
echo nginx is active
