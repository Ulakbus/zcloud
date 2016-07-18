#!/bin/sh
# create app directory and clone zaerp master
mkdir /app
cd /app

### Clone ulakbus from github ###
git clone https://github.com/zetaops/ulakbus.git

### Run setup.py ###
cd /app/ulakbus/
# checkout to the tagged version
git checkout master
python setup.py install

cd /app/ulakbus/gunicorn
pypy3 your-daemon-or-script.py
