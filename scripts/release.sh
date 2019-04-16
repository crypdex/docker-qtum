#!/usr/bin/env bash

##########################################
# Run this script with Makefile from root
# VERSION=0.17 make release
##########################################

ORG="crypdex"
SERVICE="qtum"
VERSION='0.17'
ARCH="arm64v8 x86_64"

# Build and push builds for these architectures
for arch in ${ARCH}; do
  if [ $arch = "arm64v8" ]; then
    IMAGE="arm64v8/debian:stable-slim"
    QTUM_ARCH="aarch64"
  elif [ $arch = "x86_64" ]; then
    IMAGE="debian:stable-slim"
    QTUM_ARCH="x86_64"
  fi

  echo "=> Building QTUM {arch: ${arch}, image: ${IMAGE}, qtum-arch: ${QTUM_ARCH}}"


   docker build -f ${VERSION}/Dockerfile -t ${ORG}/${SERVICE}:${VERSION}-${arch} --build-arg QTUM_ARCH=${QTUM_ARCH} --build-arg IMAGE=${IMAGE} ${VERSION}/.
   docker push ${ORG}/${SERVICE}:${VERSION}-${arch}
done


# Now create a manifest that points from latest to the specific architecture
rm -rf ~/.docker/manifests/*

# version
docker manifest create ${ORG}/${SERVICE}:${VERSION} ${ORG}/${SERVICE}:${VERSION}-x86_64 ${ORG}/${SERVICE}:${VERSION}-arm64v8
docker manifest push ${ORG}/${SERVICE}:${VERSION}

