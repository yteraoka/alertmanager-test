#!/bin/bash
#
# alertmanager に test event を送る
#

ip=$(docker-machine ip)
endpoint="http://$ip:9093/api/v1/alerts"

instance=${1:-example1}

curl -X POST $endpoint -d "
[
  {
    \"labels\": {
      \"alertname\": \"DiskFull\",
      \"device\": \"sda1\",
      \"instance\": \"${instance}\"
    },
    \"annotations\": {
      \"info\": \"The disk sda1 is running full\",
      \"summary\": \"please check the instance example1\"
    }
  }
]
"
