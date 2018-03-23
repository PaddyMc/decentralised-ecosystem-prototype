#!/bin/bash
set -ev

export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp

peer channel create -o orderer.example.com:7050 -c mychannel -f /etc/hyperledger/configtx/channel.tx
peer channel join -b mychannel.block

# peer chaincode install -n fabcar -v 1.0 -p github.com/fabcar
