FROM zetaops/zops-pypy2-git

# create app directory and clone zaerp master
RUN mkdir /app
WORKDIR /app

### Clone ulakbus from github ###
RUN git clone https://github.com/zetaops/zengine.git

### Run setup.py ###
WORKDIR /app/zengine/zengine/tornado_server

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

CMD ["pypy", "server.py"]
