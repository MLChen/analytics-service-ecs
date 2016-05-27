#!/usr/bin/env bash
set -e

sed -i -e "s,{awses_hosts},$AWSES_HOSTS,g" /opt/kibana/config/kibana.yml

echo "Starting Kibana"
exec kibana
