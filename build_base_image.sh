#! /bin/bash
echo
echo "----------- Building Base Image ----------- "
tar xf APIGateway_7.7.20220228-DockerScripts-2.4.0.tar

./apigw-emt-scripts-2.4.0/build_base_image.py \
  --installer=$HOME/APIGateway_7.7.20220228_Install_linux-x86-64_BN02.run \
  --os=centos7 \
  --out-image=romaicus/apim_base:77-20220416

docker tag romaicus/apim_base:77-20220416 romaicus/apim_base:latest
docker push romaicus/apim_base:77-20220416
docker push romaicus/apim_base:latest
