FROM pypy:3-slim

RUN pip install tornado pika

RUN mkdir /app

RUN set -x \
	&& apt-get update && apt-get install -y curl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& curl -o /app/server.py "https://raw.githubusercontent.com/zetaops/zengine/develop/zengine/tornado_server/server.py" \
	&& curl -o /app/queue_manager.py "https://raw.githubusercontent.com/zetaops/zengine/develop/zengine/tornado_server/queue_manager.py" \
	&& apt-get purge -y --auto-remove curl

WORKDIR /app

CMD [ "pypy3", "server.py", "runserver" ]
