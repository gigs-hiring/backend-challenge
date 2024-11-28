#!/bin/bash

set -e -o pipefail

usage() {
  cat <<EOF
Usage: $0 <service-url>

Sends all test events to the specified service URL.

Example:
  $0 http://localhost:3000/notifications

EOF
}

abort() {
  local msg=$1
  local code=${2-1}
  echo >&2 -e "Error: $msg"
  exit "$code"
}

if [[ $# -eq 0 ]]; then
  usage
  abort "Missing service-url argument"
fi
service_url="$1"

parent_directory=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd "$parent_directory"

for event in events/event-*.json; do
  curl \
  --request POST\
  --data "@$event" \
  --header "Content-Type: application/json" \
  --connect-timeout 2 \
  --fail \
  --silent \
  --show-error \
  --url "$service_url"
done
