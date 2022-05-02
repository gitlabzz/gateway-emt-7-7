#! /bin/bash
echo
echo "----------- Building Admin Node Manager for environment '$1' ----------- "
tar xf APIGateway_7.7.20220228-DockerScripts-2.4.0.tar
# get the certificate from environment variable
echo "${APIGATEWAY_LICENSE}" | base64 -d >license.lic
echo "----------- Using following license ----------- "
cat license.lic

./apigw-emt-scripts-2.4.0/build_anm_image.py \
  --license=license.lic \
  --domain-cert=anm/certs/$1/cert.pem \
  --domain-key=anm/certs/$1/key.pem \
  --domain-key-pass-file=anm/certs/$1/pass.txt \
  --merge-dir anm/merge-dir/apigateway \
  --metrics \
  --anm-username=admin \
  --anm-pass-file=anm/anm.pass.txt \
  --parent-image=romaicus/apim_base:$2 \
  --out-image=romaicus/apim_anm:$2

docker tag romaicus/apim_anm:$2 romaicus/apim_anm:latest
docker push romaicus/apim_anm:$2
docker push romaicus/apim_anm:latest