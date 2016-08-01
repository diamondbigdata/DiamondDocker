#!/bin/sh
set -e
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
#exec /usr/local/bin/node /cloud9/server.js --listen 0.0.0.0 --port 80 -w /workspace

