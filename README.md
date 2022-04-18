# gateway-emt-7-7

To build run 'build_all.sh' with environment name, for example: 
./build_all.sh 'dev'

This will create and push following docker images to https://hub.docker.com/u/romaicus:
romaicus/apim_base
romaicus/apim_anm
romaicus/apimgr


## Cassandra Setup

Install JDK 1.8

Unzip cassandra.zip

Update cassandra/bin/cassandra.in.sh: update JAVA_HOME to refer to you local JDK installation

Update cassandra/conf/cassandra.yaml, for following:

start_rpc: true
rpc_address: 0.0.0.0
broadcast_rpc_address: node_ip
listen_address:node_ip
seed_provider -> class_name -> seeds -> node_ip



## MySQL Setup

sudo apt update -y
sudo apt install mysql-server
sudo systemctl start mysql.service
sudo systemctl status mysql.service
sudo systemctl enable mysql.service
sudo mysql_secure_installation
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf -> bind-address = 0.0.0.0
sudo systemctl restart mysql
sudo mysql
create database metrics;
CREATE USER 'gateway_user'@'%' IDENTIFIED BY 'changeme';
GRANT ALL PRIVILEGES ON metrics.* TO 'gateway_user'@'%';
exit
mysql -u gateway_user -p
changeme
show databases;
exit
sudo ufw disable



### Test MySQL Remote Connectivity

Go to Gateway EMT machine that has Docker installed already
docker run --name adminer-db -p 8086:8080 -d adminer (this will run Adminer container)
In browser http://localhost:8086 (enter database IP and gateway_user/ changeme to connect)


## To run apimgr container locally:

mkdir -p ~/merge-dir/apigateway/logs
mkdir -p ~/merge-dir/apigateway/events
mkdir -p ~/merge-dir/apigateway/conf/licenses
cp lic20.lic conf/licenses/
docker network create api-gateway-domain
Run anm:

docker run -d -p 8090:8090 --name=anm77 --network=api-gateway-domain -v /home/asim/merge-dir/apigateway/events:/opt/Axway/apigateway/events -e METRICS_DB_URL=jdbc:mysql://172.16.63.178:3306/metrics?useSSL=false -e EMT_TRACE_LEVEL=INFO -e ACCEPT_GENERAL_CONDITIONS=yes apim_anm_202204:7.7

OR

docker run -d -p 8090:8090 --name=anm77 --network=api-gateway-domain -v /home/asim/merge-dir/apigateway/events:/opt/Axway/apigateway/events -e METRICS_DB_URL=jdbc:mysql://172.16.63.178:3306/metrics?useSSL=false -e EMT_TRACE_LEVEL=INFO -e ACCEPT_GENERAL_CONDITIONS=yes romaicus/anm:7.7

Run gwt:

docker run -d --name=apimgr77 --network=api-gateway-domain -p 8075:8075 -p 8065:8065 -p 8080:8080 -v /home/asim/merge-dir/apigateway/events:/opt/Axway/apigateway/events -v /home/asim/merge-dir/apigateway/logs:/opt/Axway/apigateway/logs -v /home/asim/merge-dir/apigateway/conf/licenses:/opt/Axway/apigateway/conf/licenses -e EMT_ANM_HOSTS=anm77:8090 -e EMT_DEPLOYMENT_ENABLED=true -e CASS_HOST1=172.16.63.177 -e CASS_HOST2=172.16.63.177 -e CASS_HOST3=172.16.63.177 -e CASS_PORT1=9042 -e CASS_PORT2=9042 -e CASS_PORT3=9042 -e CASS_USERNAME=cassandra -e CASS_PASS=changeme -e METRICS_DB_URL=jdbc:mysql://172.16.63.178:3306/metrics?useSSL=false -e METRICS_DB_USERNAME=gateway_user -e METRICS_DB_PASS=changeme -e EMT_TRACE_LEVEL=INFO -e ACCEPT_GENERAL_CONDITIONS=yes apim_apig_202204:7.7

OR

docker run -d --name=apimgr77 --network=api-gateway-domain -p 8075:8075 -p 8065:8065 -p 8080:8080 -v /home/asim/merge-dir/apigateway/events:/opt/Axway/apigateway/events -v /home/asim/merge-dir/apigateway/logs:/opt/Axway/apigateway/logs -v /home/asim/merge-dir/apigateway/conf/licenses:/opt/Axway/apigateway/conf/licenses -e EMT_ANM_HOSTS=anm77:8090 -e EMT_DEPLOYMENT_ENABLED=true -e CASS_HOST1=172.16.63.177 -e CASS_HOST2=172.16.63.177 -e CASS_HOST3=172.16.63.177 -e CASS_PORT1=9042 -e CASS_PORT2=9042 -e CASS_PORT3=9042 -e CASS_USERNAME=cassandra -e CASS_PASS=changeme -e METRICS_DB_URL=jdbc:mysql://172.16.63.178:3306/metrics?useSSL=false -e METRICS_DB_USERNAME=gateway_user -e METRICS_DB_PASS=changeme -e EMT_TRACE_LEVEL=INFO -e ACCEPT_GENERAL_CONDITIONS=yes romaicus/gateway:7.7

https://localhost:8075/home https://localhost:8090/

docker exec -it apimgr77 /bin/bash
cd /opt/Axway/apigateway/posix/bin
./dbsetup --dburl=jdbc:mysql://172.16.63.178:3306/metrics?allowPublicKeyRetrieval=false --dbuser=gateway_user --dbpass=changeme
look for message: New database About to upgrade schema. Please note that this operation may take some time for very large databases Schema successfully upgraded to: 002-leaf

mysql -u gateway_user -p changeme show databases; use metrics; 

mysql> show tables; 
