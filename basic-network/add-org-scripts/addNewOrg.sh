#!/bin/sh

#../docker-compose -f docker-compose-org3.yaml up -d
#docker exec -it Org3cli bash

#export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem && export CHANNEL_NAME=mychannel

#peer channel fetch 0 mychannel.block -o orderer.example.com:7050 -c $CHANNEL_NAME --tls --cafile $ORDERER_CA

#peer channel join -b mychannel.block

#peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/chaincode_example02/go/

#peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'