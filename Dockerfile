FROM mariadb:10.11.4

LABEL org.opencontainers.image.title="wordpress-mariadb" \
      org.opencontainers.image.description="mariadb docker image for my WordPress stack" \
      org.opencontainers.image.source="https://github.com/kugland/docker-wordpress-mariadb" \
      org.opencontainers.image.authors="André Kugland <kugland@gmail.com>"

RUN { \
  set -eux ; \
  apt-get update && apt-get install -y -q --no-install-recommends netcat-openbsd ; \
  apt-get clean -y -q ; \
  rm -rf /var/lib/apt/lists/* ; \
}

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY './mysqldump.sh' /usr/local/bin
RUN chmod +x /usr/local/bin/mysqldump.sh

VOLUME [ "/var/log/mariadb" ]

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "mysqld" ]
