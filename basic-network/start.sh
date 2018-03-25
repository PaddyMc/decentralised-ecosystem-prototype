#!/bin/bash
# Exit on first error, print all commands.
set -ev
./generate.sh
# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

docker-compose -f docker-compose.yml up -d
sleep 5

echo
echo "========== Starting peer 0 org 1 =========="
docker exec peer0.org1.example.com /opt/gopath/src/github.com/hyperledger/fabric/setup.sh
sleep 3

echo
echo "========== Starting ipfs filesys =========="
./ipfsConfig.sh

echo
echo "========== Starting peer 1 org 1 =========="
docker exec peer1.org1.example.com /opt/gopath/src/github.com/hyperledger/fabric/setup.sh
sleep 3


echo
echo "========== Starting peer 0 org 2 =========="
docker exec peer0.org2.example.com /opt/gopath/src/github.com/hyperledger/fabric/setup.sh
sleep 3


echo
echo "========== Starting peer 1 org 2 =========="
docker exec peer1.org2.example.com /opt/gopath/src/github.com/hyperledger/fabric/setup.sh
sleep 3

echo
echo "========== Starting cli =========="
docker exec cli /opt/gopath/src/github.com/hyperledger/fabric/peer/cliSetup.sh
sleep 3
