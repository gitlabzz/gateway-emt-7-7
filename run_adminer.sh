#!/bin/bash
echo
echo "----------- Running Adminer Container ----------- "
docker run --name adminer-db -p 8086:8080 -d adminer