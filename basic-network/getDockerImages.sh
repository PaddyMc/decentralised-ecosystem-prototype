#!/bin/bash

export VERSION=${1:-1.1.0}
export CA_VERSION=${2:-$VERSION}

export THIRDPARTY_IMAGE_VERSION=0.4.6
export ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')

MARCH=`uname -m`

dockerFabricPull() {
  local FABRIC_TAG=$1
  for IMAGES in peer orderer ccenv javaenv tools; do
      echo "==> FABRIC IMAGE: $IMAGES"
      echo
      docker pull hyperledger/fabric-$IMAGES:$FABRIC_TAG
      docker tag hyperledger/fabric-$IMAGES:$FABRIC_TAG hyperledger/fabric-$IMAGES
  done
}

dockerThirdPartyImagesPull() {
  local THIRDPARTY_TAG=$1
  for IMAGES in couchdb kafka zookeeper; do
      echo "==> THIRDPARTY DOCKER IMAGE: $IMAGES"
      echo
      docker pull hyperledger/fabric-$IMAGES:$THIRDPARTY_TAG
      docker tag hyperledger/fabric-$IMAGES:$THIRDPARTY_TAG hyperledger/fabric-$IMAGES
  done
}

dockerCaPull() {
      local CA_TAG=$1
      echo "==> FABRIC CA IMAGE"
      echo
      docker pull hyperledger/fabric-ca:$CA_TAG
      docker tag hyperledger/fabric-ca:$CA_TAG hyperledger/fabric-ca
}

: ${CA_TAG:="$MARCH-$CA_VERSION"}
: ${FABRIC_TAG:="$MARCH-$VERSION"}
: ${THIRDPARTY_TAG:="$MARCH-$THIRDPARTY_IMAGE_VERSION"}

which docker >& /dev/null
NODOCKER=$?

if [ "${NODOCKER}" == 0 ]; then

	echo "===> Pulling fabric Images"
	dockerFabricPull ${FABRIC_TAG}

	echo "===> Pulling fabric ca Image"
	dockerCaPull ${CA_TAG}

	echo "===> Pulling thirdparty docker images"
	dockerThirdPartyImagesPull ${THIRDPARTY_TAG}
	echo

	echo "===> List out hyperledger docker images"
	docker images | grep hyperledger*
else
	echo "========================================================="
	echo "Docker not installed, bypassing download of Fabric images"
	echo "========================================================="
fi
