FROM zetaops/ulakbus-base

# Checkout latest tag
RUN git checkout $(git describe --tags `git rev-list --tags --max-count=1`)

RUN python setup.py install

RUN apt-get purge -y gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app/ulakbus/ulakbus
CMD ["python", "manage.py", "runserver"]
