#!/bin/sh

set -e
eval $(ssh-agent) >/dev/null
exec "$@"
