#!/bin/sh
set -eu

PROJECT="dockerhwcheck$(date +%s)$$"
BACKUP="${BACKUP_FILE:-$(pwd)/redis-backup.tar}"
STEP="initialization"
cleanup() {
  docker compose -p "$PROJECT" -f compose.yaml down -v --remove-orphans >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM
fail() { echo "FAIL [$STEP]: $*" >&2; exit 1; }
compose() { docker compose -p "$PROJECT" -f compose.yaml "$@"; }
wait_http() {
  url="$1"; expected="$2"; i=0
  while [ "$i" -lt 60 ]; do
    code=$(curl -sS --max-time 2 -o /tmp/dockerhw-response-$$ -w '%{http_code}' "$url" 2>/dev/null || true)
    if [ "$code" = "$expected" ]; then cat "/tmp/dockerhw-response-$$"; rm -f "/tmp/dockerhw-response-$$"; return 0; fi
    i=$((i + 1)); sleep 1
  done
  fail "timeout waiting for $url to return HTTP $expected"
}
count_from() { printf '%s' "$1" | sed -n 's/.*"count"[ ]*:[ ]*\([0-9][0-9]*\).*/\1/p'; }
STEP="build and initial startup"
compose up -d --build || fail "compose up failed"
BASE="http://127.0.0.1:${APP_PORT:-8080}"
wait_http "$BASE/readyz" 200 >/dev/null
STEP="initial count"
initial=$(wait_http "$BASE/" 200); [ "$(count_from "$initial")" = 0 ] || fail "initial count is not zero"
N=${N:-5}; i=0
while [ "$i" -lt "$N" ]; do wait_http "$BASE/increment" 200 >/dev/null # replaced below: endpoint is POST
  i=$((i + 1))
done
STEP="increment requests"
