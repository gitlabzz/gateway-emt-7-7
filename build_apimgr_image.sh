#! /bin/bash
tar xf APIGateway_7.7.20220228-DockerScripts-2.4.0.tar
echo $APIGATEWAY_LICENSE | base64 -d >license.lic
./apigw-emt-scripts-2.4.0/build_gw_image.py --license=license.lic --domain-cert=certs/mydomain/mydomain-cert.pem --domain-key=certs/mydomain/mydomain-key.pem --domain-key-pass-file=certs/mydomain/mydomain.pass.txt --merge-dir apimgr/merge-dir/apigateway --pol=apimgr/policy_config/docker-apim-vanilla.pol --env=apimgr/policy_config/docker-apim-vanilla.env --fed-pass-file=apimgr/nopass.txt --parent-image=romaicus/apim_base:77-20220416 --out-image=romaicus/apimgr:77-20220416