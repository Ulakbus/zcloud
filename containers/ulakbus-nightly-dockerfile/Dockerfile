FROM zetaops/ulakbus-base

RUN python setup.py install

RUN apt-get purge -y gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app/ulakbus/ulakbus
CMD ["python ", "manage.py ", "runserver"]
