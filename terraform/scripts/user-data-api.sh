#!/usr/bin/env bash

cat <<EOT >> api.service
[Unit]
Description=API module init service
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/api
ExecStart=/bin/bash /home/ubuntu/api/api-init.sh ${PASSWORD} ${DB_HOSTNAME} ${PORT}
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=[NODE_API]
RestartSec=10

[Install]
WantedBy=multi-user.target
EOT

sudo cp api.service /etc/systemd/system/
sudo systemctl start api



until tail /var/log/syslog | grep 'node ./bin/www' > /dev/null; do sleep 5; done