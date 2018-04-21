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

addPeers