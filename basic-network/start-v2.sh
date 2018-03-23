#!/bin/bash
# Exit on first error, print all commands.
set -ev
./generate.sh
# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

docker-compose -f docker-compose.yml up -d
sleep 10

echo
echo "========== Starting peer 0 org 1 =========="
docker cp peer-setup-scripts/peer0org1Setup.sh peer0.org1.example.com:/opt/gopath/src/github.com/hyperledger/fabric/peer0org1Setup.sh
docker exec peer0.org1.example.com /opt/gopath/src/github.com/hyperledger/fabric/peer0org1Setup.sh
sleep 3
docker cp peer0.org1.example.com:/opt/gopath/src/github.com/hyperledger/fabric/mychannel.block .
#
# echo
# echo "========== Starting peer 1 org 1 =========="
# docker cp mychannel.block peer1.org1.example.com:/opt/gopath/src/github.com/hyperledger/fabric/
# docker cp peer-setup-scripts/peer1org1Setup.sh cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/peer1org1Setup.sh
# docker exec cli /opt/gopath/src/github.com/hyperledger/fabric/peer/peer1org1Setup.sh
# sleep 3


echo
echo "========== Starting peer 0 org 2 =========="
docker cp mychannel.block peer0.org2.example.com:/opt/gopath/src/github.com/hyperledger/fabric/
docker cp peer-setup-scripts/peer0org2Setup.sh peer0.org2.example.com:/opt/gopath/src/github.com/hyperledger/fabric/peer0org2Setup.sh
docker exec peer0.org2.example.com /opt/gopath/src/github.com/hyperledger/fabric/peer0org2Setup.sh
sleep 3


# echo
# echo "========== Starting peer 1 org 2 =========="
# docker cp mychannel.block peer1.org2.example.com:/opt/gopath/src/github.com/hyperledger/fabric/
# docker cp peer-setup-scripts/peer1org2Setup.sh cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/peer1org2Setup.sh
# docker exec cli /opt/gopath/src/github.com/hyperledger/fabric/peer/peer1org2Setup.sh
# sleep 3

echo
echo "========== Starting cli =========="
docker cp peer-setup-scripts/cliSetup.sh cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/cliSetup.sh
docker exec cli /opt/gopath/src/github.com/hyperledger/fabric/peer/cliSetup.sh
sleep 3
