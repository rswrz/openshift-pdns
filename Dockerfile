FROM alpine:3.9
MAINTAINER "Roman Schwarz" <root@rswrz.net>

RUN apk add --no-cache \
    pdns \
    pdns-backend-mysql \
    pdns-doc \
    python3 \
    mariadb-client \
  && pip3 install --no-cache-dir envtpl \
  && chgrp -R root /etc/pdns \
  && chmod -R g=u /etc/pdns

ENV VERSION=4.1 \
  PDNS_guardian=yes \
  PDNS_setuid=pdns \
  PDNS_setgid=pdns \
  PDNS_launch=gmysql

EXPOSE 53 53/udp

COPY pdns.conf.tpl /
COPY docker-entrypoint.sh /


USER 65534

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "/usr/sbin/pdns_server" ]
