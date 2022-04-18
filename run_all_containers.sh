#! /bin/bash
echo
echo "----------- Runing All Containers ----------- "
./create_docker_network.sh
./run_adminer.sh
./run_anm_container.sh
./run_apimgr_container.sh 172.16.63.174 9042 172.16.63.175 3306 gateway_user changeme
