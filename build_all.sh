#! /bin/bash
echo "Going to build base image, anm image and apim image"

echo
echo "Building Base Image"
./build_base_image.sh "$@"

echo
echo "Building Admin Node Manager Image"
./build_anm_image.sh "$@"

echo
echo "Building API Manager Image"
./build_apimgr_image.sh "$@"

#echo
#echo "Building API Gateway Analytics Image"
#./build_aga_image.sh "$@"

#echo
#echo "Building API Portal Image"
#./build_api_portal_image.sh "$@"
