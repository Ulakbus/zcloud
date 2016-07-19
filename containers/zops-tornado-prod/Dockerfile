FROM zetaops/zops-pypy3-git

# create app directory and clone zaerp master
RUN mkdir /app
WORKDIR /app

### Clone ulakbus from github ###
RUN git clone https://github.com/zetaops/zengine.git

### Run setup.py ###
WORKDIR /app/zengine/zengine/tornado_server

RUN git checkout $(git describe --tags `git rev-list --tags --max-count=1`)

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

CMD ["pypy", "server.py"]
