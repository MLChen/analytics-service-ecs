#!/usr/bin/env bash
set -e

echo "$CREDENTIALS" | base64 --decode > /usr/share/grafana/.aws/credentials
chown grafana:grafana -R /usr/share/grafana/.aws/ && chmod 600 /usr/share/grafana/.aws/credentials

sed -i -e "s,{grafana_admin},$GRAFANA_ADMIN,g" /etc/grafana/grafana.ini
sed -i -e "s,{grafana_password},$GRAFANA_PASSWORD,g" /etc/grafana/grafana.ini
sed -i -e "s,{grafana_domain},$GRAFANA_DOMAIN,g" /etc/grafana/grafana.ini

echo "$GRAFANA_DB" | base64 --decode >> /etc/grafana/grafana.ini
echo "$GRAFANA_SSO" | base64 --decode >> /etc/grafana/grafana.ini

service grafana-server start

sleep infinity
