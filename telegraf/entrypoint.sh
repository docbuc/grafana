#!/bin/bash
# Datei: grafana/telegraf/entrypoint.sh
set -e

INFLUXDB_HOST=${INFLUXDB_HOST:-influx}
INFLUXDB_PORT=${INFLUXDB_PORT:-8086}
INFLUXDB_TOKEN=${INFLUXDB_TOKEN:-geheim}
INFLUXDB_BUCKET=${INFLUXDB_BUCKET:-bucket1}
INFLUXDB_ORG=${INFLUXDB_ORG:-org}

sed -i "s/influx:8086/$INFLUXDB_HOST:$INFLUXDB_PORT/g;
  s/token = \"geheim\"/token = \"$INFLUXDB_TOKEN\"/g;
  s/organization = \"org\"/organization = \"$INFLUXDB_ORG\"/g;
  s/bucket = \"bucket1\"/bucket = \"$INFLUXDB_BUCKET\"/g" \
    /etc/telegraf/telegraf.conf

if [ "${1:0:1}" = '-' ]; then
    set -- telegraf "$@"
fi

exec "$@"

