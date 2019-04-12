FROM python:3.7-alpine3.9

ENV PYTHONDONTWRITEBYTECODE=1
ENV PATH="/root/bin:${PATH}"

RUN apk add --no-cache \
      fortune \
      perl && \
    wget -O cowsay.zip https://github.com/schacon/cowsay/archive/master.zip && \
    unzip cowsay.zip && cd /cowsay-master && sh install.sh && \
    cd / && \
    wget -O pokemonsay.zip https://github.com/possatti/pokemonsay/archive/master.zip && \
    unzip pokemonsay.zip && cd /pokemonsay-master && sh install.sh && \
    cd / && \
    apk add --no-cache -t build  \
      openssl \
      texinfo && \
    wget -O ponysay.zip https://github.com/erkin/ponysay/archive/master.zip && \
    unzip ponysay.zip && cd ponysay-master && \
    ./setup.py install --freedom=partial && \
    cd / && \
    apk del --no-cache build && \
    rm -rf /ponysay.zip /ponysay-master /cowsay.zip /cowsay-master /pokemonsay.zip /pokemonsay-master

COPY say /usr/local/bin/say
RUN chmod +x /usr/local/bin/say

CMD ["/bin/sh", "-c", "fortune | say" ]
