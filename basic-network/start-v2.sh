#!/bin/bash
# Exit on first error, print all commands.
set -ev
./generate.sh
# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

docker-compose -f docker-compose.yml up -d

export FABRIC_START_TIMEOUT=10
sleep ${FABRIC_START_TIMEOUT}

docker cp cliSetup.sh cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/start.sh

sleep 2

docker exec cli /opt/gopath/src/github.com/hyperledger/fabric/peer/start.sh
