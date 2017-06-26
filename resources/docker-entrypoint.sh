#!/bin/bash
set -eo pipefail

/usr/local/bin/ep -v /home/eth-proxy/eth-proxy.conf

exec "$@"
