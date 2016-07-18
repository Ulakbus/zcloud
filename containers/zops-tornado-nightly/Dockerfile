FROM zops-pypy3-git

# create app directory and clone zaerp master
RUN mkdir /app
WORKDIR /app

### Clone ulakbus from github ###
RUN git clone https://github.com/zetaops/zengine.git

### Run setup.py ###
WORKDIR /app/zengine/

RUN pypy3 setup.py install

# Open ports for HTTP and Protocol Buffers
EXPOSE 9001

CMD ["pypy3" "/app/zengine/zengine/tornado_server/server.py"]
