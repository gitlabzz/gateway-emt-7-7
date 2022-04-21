#! /bin/bash
echo
echo "----------- Building API Portal Image for environment '$1' ----------- "

tar xf APIPortal_7.7.20220228_Docker_Samples_Package_linux-x86-64_BN724.tar
mv apiportal-docker-* api_portal_build

docker image build \
  -t romaicus/apim_apiportal:77-20220416 \
  --build-arg MYSQL_HOST=172.16.63.175 \
  --build-arg MYSQL_PORT=3306 \
  --build-arg MYSQL_DATABASE=api_portal \
  --build-arg MYSQL_USER=api_portal_user \
  --build-arg MYSQL_PASSWORD=changeme \
  api_portal_build/

docker tag romaicus/apim_apiportal:77-20220416 romaicus/apim_apiportal:latest
docker push romaicus/apim_apiportal:77-20220416
docker push romaicus/apim_apiportal:latest
