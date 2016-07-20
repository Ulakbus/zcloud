FROM zetaops/ulakbus-base

# create app directory and clone zaerp master
RUN mkdir /app
WORKDIR /app

RUN "sed -i \"1s/^/import sys \nsys.setdefaultencoding('utf-8') \n /\" /etc/python2.7/sitecustomize.py"

### Clone ulakbus from github ###
RUN git clone https://github.com/zetaops/ulakbus.git

### Run setup.py ###
WORKDIR /app/ulakbus/

# Checkout latest tag
RUN git checkout $(git describe --tags `git rev-list --tags --max-count=1`)

RUN python setup.py install

RUN apt-get purge -y gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app/ulakbus/ulakbus
CMD ["python", "manage.py", "runserver"]
