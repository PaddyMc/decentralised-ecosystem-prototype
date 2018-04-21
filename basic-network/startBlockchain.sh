#!/bin/bash
set -e

addPeers(){
	for peer in peer1.org1.example.com peer0.org2.example.com peer1.org2.example.com; do
		echo
		echo "========== $peer joining =========="

		docker exec $peer /opt/gopath/src/github.com/hyperledger/fabric/setup.sh
		sleep 2
	done
}

#./generate.sh

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

docker-compose -f docker-compose.yml up -d
sleep 5

echo
echo "========== peer0.org1.example.com joining =========="
docker exec peer0.org1.example.com /opt/gopath/src/github.com/hyperledger/fabric/setup.sh
sleep 3

#echo
#echo "========== Starting ipfs filesys =========="
#./ipfsConfig.sh

#addPeers

#echo
#echo "========== Starting cli =========="
#docker exec cli /opt/gopath/src/github.com/hyperledger/fabric/peer/setup.sh
sleep 3
