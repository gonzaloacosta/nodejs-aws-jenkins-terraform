#!/usr/bin/env bash

cat <<EOT >> web.service
[Unit]
Description=Web module init service
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/web
ExecStart=/bin/bash /home/ubuntu/web/web-init.sh ${API_HOSTNAME} ${API_PORT} ${WEB_PORT}
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=[NODE_WEB]
RestartSec=10

[Install]
WantedBy=multi-user.target
EOT

sudo cp web.service /etc/systemd/system/
sudo systemctl start web

until tail /var/log/syslog | grep 'node ./bin/www' > /dev/null; do sleep 5; done