#!/bin/bash

echo
echo "----------- Creating Directories for APIMGR ----------- "

mkdir -p apimgr/merge-dir/apigateway/events
mkdir -p apimgr/merge-dir/apigateway/logs
mkdir -p apimgr/merge-dir/apigateway/conf/licenses

echo "${APIGATEWAY_LICENSE}" | base64 -d >apimgr/merge-dir/apigateway/conf/licenses/license.lic
