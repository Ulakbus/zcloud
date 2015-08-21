#!/bin/sh
# create app directory and clone zaerp master
mkdir /app
cd /app

### Clone ulakbus from github ###
git clone https://github.com/zetaops/ulakbus.git

### Run setup.py ###
cd /app/ulakbus/
python setup.py install

### Run Server ###
cd /app/ulakbus/ulakbus/
python runserver.py
