#!/bin/bash
set -eo pipefail
shopt -s nullglob

cd /usr/src/app
exec yarn start
