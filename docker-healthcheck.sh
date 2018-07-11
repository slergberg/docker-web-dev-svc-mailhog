#!/usr/bin/env sh

set -x

healthcheck_smtp_server() {
  echo HELO smtp \
    | echo quit \
    | curl --data-ascii - telnet://0.0.0.0:25 \
    || exit 1
}

healthcheck_web_server() {
  curl --fail http://0.0.0.0:1080 \
    || exit 1
}

healthcheck_smtp_server && healthcheck_web_server
