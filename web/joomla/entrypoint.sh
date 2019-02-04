#!/bin/bash
set -e

service mysql start
service apache2 start

trap true SIGINT SIGTERM

(
  while sleep 20; do
    PS="$(ps aux)"
    for process_name in apache2 mysql; do
      if ! grep "$process_name" <<< "$PS" | grep -q -v grep; then
        echo "$process_name" process has exited unexpectedly
        exit 1
      fi
    done
  done
) &

wait $! || true

echo Exiting ... >&2

service apache2 stop
service mysql stop
