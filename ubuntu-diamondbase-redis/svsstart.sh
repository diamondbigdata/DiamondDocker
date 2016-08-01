#!/bin/sh
set -e
exec /usr/local/bin/redis-server /etc/redis.conf  > /var/log/redis.log 2>&1

