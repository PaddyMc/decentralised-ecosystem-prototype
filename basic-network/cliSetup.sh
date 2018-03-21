#!/bin/bash
set -ev
# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
export FABRIC_START_TIMEOUT=10


peer channel create -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx

peer channel join -b mychannel.block

peer chaincode install -n fabcar -v 1.0 -p github.com/fabcar

peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n fabcar -v 1.0 -c '{"Args":[""]}' -P "OR ('Org1MSP.member','Org2MSP.member')"
sleep 5

peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n fabcar -c '{"function":"initLedger","Args":[""]}'
