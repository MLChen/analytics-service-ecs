#!/usr/bin/env bash
set -e

mkdir -p /root/.s3fs
echo $ANALYTICS_ACCESSKEY:$ANALYTICS_SECRETKEY > /root/.s3fs/passwd
chmod 600 /root/.s3fs/passwd
s3fs ecowork-analysis /storage -o passwd_file=/root/.s3fs/passwd

sleep infinity
