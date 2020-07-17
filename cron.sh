#!/bin/sh
set -e

echo "Setting up cron service"
mkdir -p /etc/cron.d
echo "$CRON_SCHEDULE /job.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/docker_cron
crontab /etc/cron.d/docker_cron

# carry over environment
(env | grep -v PWD | sed 's/^\(.*\)/export \1/g') > /env.sh
cat env.sh

echo "Starting cron"
touch /var/log/cron.log
tail -f /var/log/cron.log &
$CRON_BINARY -f
