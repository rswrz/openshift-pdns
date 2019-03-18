FROM alpine:3.9
MAINTAINER "Roman Schwarz" <root@rswrz.net>

RUN apk add --no-cache \
    pdns \
    pdns-backend-mysql \
    pdns-doc \
    python3 \
    mariadb-client \
  && pip3 install --no-cache-dir envtpl \
  && mkdir -p /etc/pdns /var/run \
  && chgrp -R root /etc/pdns /var/run \
  && chmod -R g=u /etc/pdns /var/run

ENV VERSION=4.1 \
  PDNS_guardian=yes \
  PDNS_launch=gmysql \
  PDNS_local_port=5353

EXPOSE 5353 5353/udp

COPY pdns.conf.tpl /
COPY docker-entrypoint.sh /

USER 65534

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "/usr/sbin/pdns_server" ]
