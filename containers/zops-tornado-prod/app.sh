#!/bin/sh
# create app directory and clone zaerp master
mkdir /app
cd /app

### Clone ulakbus from github ###
git clone https://github.com/zetaops/zengine.git

### Run setup.py ###
cd /app/zengine/
# checkout to the tagged version
git checkout master
python setup.py install

cd /app/zengine/zengine/tornado_server
pypy3 server.py
