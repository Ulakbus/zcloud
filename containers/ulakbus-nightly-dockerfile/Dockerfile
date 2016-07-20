FROM zetaops/ulakbus-base

### Clone ulakbus from github ###
RUN git clone https://github.com/zetaops/ulakbus.git

### Run setup.py ###
WORKDIR /app/ulakbus/

RUN python setup.py install

RUN apt-get purge -y gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app/ulakbus/ulakbus
CMD ["python ", "manage.py ", "runserver"]
