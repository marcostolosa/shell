#!/bin/bash
SERVICE=$1
INSTANCES=$(ps auxw | pgrep "$SERVICE")
PIDS=$(echo "$INSTANCES" | awk '{print}' ORS=' ' && echo "")


if [ "$(ps auxw | pgrep "$SERVICE" | wc -l)" != "1" ]
then
    file="/root/logs/check.log"
    if [ ! -f "$file" ]
    then
        mkdir -p /root/logs
        touch /root/logs/check.log
    fi

    date >> /root/logs/check.log
    echo "[ WARNING ] More than 01 instance is running!" >> /root/logs/check.log
    curl -X POST -H 'Content-Type: application/json' --data '{"icon_emoji":":radioactive:","text":"More than one instances of **Example** running!","attachments":[{"title":"Name - Example Service","title_link":"https://github.com/<ID>/<Service_Name>/","text":"Service Description","color":"#CE2121"}]}' 'https://example.com/webhooks/<ID>'

    kill -9 "$PIDS"
    systemctl restart "$SERVICE"
else
    date >> /root/logs/check.log
    echo "All good, just 01 instance is running." >> /root/logs/check.sh
fi
