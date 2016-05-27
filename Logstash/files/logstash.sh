#!/usr/bin/env bash

set -e
mkdir -p /root/.s3fs
echo $ANALYTICS_ACCESSKEY:$ANALYTICS_SECRETKEY > /root/.s3fs/passwd
chmod 600 /root/.s3fs/passwd
s3fs ecowork-analysis /storage -o passwd_file=/root/.s3fs/passwd

touch /var/log/cron.log
echo "0 0 * * * /bin/bash -l -c \"curator --use_ssl --port 443 --host $AWSES_HOSTS delete indices --older-than 180 --time-unit days --timestring '%Y.%m.%d'\" >> /var/log/cron.log 2>&1" | crontab -
cron

sed -i -e "s,{bucket},$LOGS_BUCKET,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{prefix},$LOGS_PREFIX,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{region},$LOGS_BUCKET_REGION,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{s3_access_key},$LOGS_S3_ACCESSKEY,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{s3_secret_key},$LOGS_S3_SECRETKEY,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{awses_hosts},$AWSES_HOSTS,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{awses_region},$AWSES_REGION,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{analytics_access_key},$ANALYTICS_ACCESSKEY,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{analytics_secret_key},$ANALYTICS_SECRETKEY,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{project},$PROJECT,g" /etc/logstash/conf.d/$LOGS_TYPE.conf
sed -i -e "s,{logs_type},$LOGS_TYPE,g" /etc/logstash/conf.d/$LOGS_TYPE.conf

/opt/logstash/bin/logstash -f /etc/logstash/conf.d/$LOGS_TYPE.conf
