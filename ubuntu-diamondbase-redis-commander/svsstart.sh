#!/bin/sh
set -e
exec /usr/local/bin/redis-commander --redis-host redis > /var/log/redis-commander.log 2>&1 