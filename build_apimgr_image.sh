#! /bin/bash
echo
echo "----------- Building API Manager for environment '$1' ----------- "
tar xf APIGateway_7.7.20220228-DockerScripts-2.4.0.tar
# get the certificate from environment variable
echo "${APIGATEWAY_LICENSE}" | base64 -d >license.lic
echo "----------- Using following license ----------- "
cat license.lic

./apigw-emt-scripts-2.4.0/build_gw_image.py \
  --license=license.lic \
  --domain-cert=apimgr/certs/$1/cert.pem \
  --domain-key=apimgr/certs/$1/key.pem \
  --domain-key-pass-file=apimgr/certs/$1/pass.txt \
  --merge-dir apimgr/merge-dir/apigateway \
  --pol=apimgr/policy/$1/bct.pol \
  --env=apimgr/environment/$1/bct.env \
  --fed-pass-file=apimgr/nopass.txt \
  --parent-image=romaicus/apim_base:$2 \
  --out-image=romaicus/apimgr:$2

docker tag romaicus/apimgr:$2 romaicus/apimgr:latest
docker push romaicus/apimgr:$2
docker push romaicus/apimgr:latest