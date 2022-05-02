#! /bin/bash
RELEASE="7_7_20220228"
echo
echo "----------- Building Base Image For Release '$RELEASE' ----------- "
tar xf APIGateway_7.7.20220228-DockerScripts-2.4.0.tar

./apigw-emt-scripts-2.4.0/build_base_image.py \
  --installer=$HOME/APIGateway_7.7.20220228_Install_linux-x86-64_BN02.run \
  --os=centos7 \
  --out-image=romaicus/apim_base:$RELEASE

# create latest tag
#docker tag romaicus/apim_base:$RELEASE romaicus/apim_base:latest

# push image with release tag
#docker push romaicus/apim_base:$RELEASE

# push same image using 'latest' tag
#docker push romaicus/apim_base:latest
