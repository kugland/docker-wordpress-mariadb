#!/bin/sh

while ! nc -z mariadb 3306; do
  sleep 0.1
done

exec /usr/bin/mysqldump \
  --host mariadb \
  -u"$MYSQL_USER" \
  -p"$MYSQL_PASSWORD" \
  --opt \
  --skip-dump-date \
  --order-by-primary \
  --skip-extended-insert \
  --skip-quick \
  --skip-comments \
  --routines \
  --triggers \
  --single-transaction \
  "$MYSQL_DATABASE"
