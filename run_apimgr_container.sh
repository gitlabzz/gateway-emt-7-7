#!/bin/bash

echo
echo "----------- Creating Directories for APIMGR ----------- "

mkdir -p apimgr/merge-dir/apigateway/events
mkdir -p apimgr/merge-dir/apigateway/logs
mkdir -p apimgr/merge-dir/apigateway/conf/licenses

echo "${APIGATEWAY_LICENSE}" | base64 -d >apimgr/merge-dir/apigateway/conf/licenses/license.lic

echo "Cassandra Host: $1:$2"
echo "MySQL Host: $3:$4"
echo "MySQL User/ Password: $5/$6"

echo
echo "----------- Running APIMGR Container ----------- "
docker run -d --name=apimgr77 \
  --network=api-gateway-domain \
  -p 8075:8075 \
  -p 8065:8065 \
  -p 8080:8080 \
  -v /mnt/hgfs/tmp/gateway-emt-7-7/apimgr/merge-dir/apigateway/events:/opt/Axway/apigateway/events \
  -v /mnt/hgfs/tmp/gateway-emt-7-7/apimgr/merge-dir/apigateway/logs:/opt/Axway/apigateway/logs \
  -v /mnt/hgfs/tmp/gateway-emt-7-7/apimgr/merge-dir/apigateway/conf/licenses:/opt/Axway/apigateway/conf/licenses \
  -e EMT_ANM_HOSTS=anm77:8090 \
  -e EMT_DEPLOYMENT_ENABLED=true \
  -e CASS_HOST1=$1 \
  -e CASS_HOST2=$1 \
  -e CASS_HOST3=$1 \
  -e CASS_PORT1=$2 \
  -e CASS_PORT2=$2 \
  -e CASS_PORT3=$2 \
  -e CASS_USERNAME=cassandra \
  -e CASS_PASS=changeme \
  -e METRICS_DB_URL=jdbc:mysql://$3:$4/metrics?useSSL=false \
  -e METRICS_DB_USERNAME=$5 \
  -e METRICS_DB_PASS=$6 \
  -e EMT_TRACE_LEVEL=INFO \
  -e ACCEPT_GENERAL_CONDITIONS=yes \
  romaicus/apimgr:latest