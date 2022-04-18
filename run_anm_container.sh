#!/bin/bash
echo
echo "----------- Running ANM Container ----------- "
docker run -d -p 8090:8090 --name=anm77 --network=api-gateway-domain -v /home/asim/merge-dir/apigateway/events:/opt/Axway/apigateway/events -e METRICS_DB_URL=jdbc:mysql://172.16.63.175:3306/metrics?useSSL=false -e EMT_TRACE_LEVEL=INFO -e ACCEPT_GENERAL_CONDITIONS=yes romaicus/apim_anm:latest
