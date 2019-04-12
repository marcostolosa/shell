#!/bin/bash
SERVICE=$1
INSTANCES=$(ps auxw | pgrep "$SERVICE")
PIDS=$(echo "$INSTANCES" | awk '{print}' ORS=' ' && echo "")


if [ "$(ps auxw | pgrep "$SERVICE" | wc -l)" != "1" ]
then
    curl -X POST -H 'Content-Type: application/json' --data '{"icon_emoji":":radioactive:","text":"More than one instances of **Example** running!","attachments":[{"title":"Name - Example Service","title_link":"https://github.com/<ID>/<Service_Name>/","text":"Service Description","color":"#CE2121"}]}' 'https://example.com/webhooks/<ID>'

    kill -9 "$PIDS"
    systemctl restart <service_name>
else
    echo "All good! Just 1 instance runnning."
fi
