#!/bin/bash

sed -Ei -e '/^mysql:/{s,:999:999:,:'${DAEMON_UID:-1000}:${DAEMON_GID:-1000}':,}' /etc/passwd*
sed -Ei -e '/^mysql:/{s,:999:,:'${DAEMON_GID:-1000}':,g}' /etc/group*

exec /usr/local/bin/docker-entrypoint.sh "$@"
