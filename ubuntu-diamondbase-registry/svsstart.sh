#!/bin/sh
set -e
exec /bin/registry serve /etc/docker/registry/config.yml

