#! /bin/bash
echo
echo "----------- Building API Gateway Analytics Image for environment '$1' ----------- "
tar xf APIGateway_7.7.20220228-DockerScripts-2.4.0.tar
# get the certificate from environment variable
echo "${APIGATEWAY_ANALYTICS_LICENSE}" | base64 -d >license.lic
echo "----------- Using following license ----------- "
cat license.lic

./apigw-emt-scripts-2.4.0/build_aga_image.py \
  --installer=../APIGateway_7.7.20220228_Install_linux-x86-64_BN02.run \
  --license=license.lic \
  --os=centos7 \
  --merge-dir=aga/merge-dir/analytics \
  --analytics-username=admin \
  --analytics-pass-file=aga/pass.txt \
  --fed=aga/fed/$1/aga-healthcheck-$1.fed \
  --out-image=romaicus/apim_aga:77-20220416

docker tag romaicus/apim_aga:77-20220416 romaicus/apim_aga:latest
docker push romaicus/apim_aga:77-20220416
docker push romaicus/apim_aga:latest
