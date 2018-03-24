#!/bin/bash
set -e

CORE_PEER_ADDRESS=peer0.org2.example.com:7051
CORE_PEER_LOCALMSPID=Org2MSP
CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org2.example.com/msp
CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/tls/ca.crt

peer channel join -b mychannel.block

# peer chaincode install -n fabcar -v 1.0 -p github.com/fabcar
