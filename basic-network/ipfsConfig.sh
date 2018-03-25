#!/bin/bash

initIPFS(){
	for i in peer0.org1.example.com peer1.org1.example.com peer0.org2.example.com peer1.org2.example.com; do
		docker exec "$i" ipfs init
		docker exec "$i" ipfs config LIBP2P_FORCE_PNET 1
		docker exec "$i" ipfs bootstrap rm --all
		docker exec "$i" cp /go-ipfs/swarm.key ~/.ipfs
	done
}

createBootstrapNodeAddress()
{
	IPADDRESS=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1)
	IPFSID="$(docker exec $1 ipfs config Identity.PeerID)"
	echo "/ip4/""$IPADDRESS""/tcp/4001/ipfs/""$IPFSID"
}

addBootstrapPeers(){
	docker exec "$1" ipfs bootstrap add "$2" "$3" "$4"
}

initializeSwarm(){
	for i in peer0.org1.example.com peer1.org1.example.com peer0.org2.example.com peer1.org2.example.com; do
		docker exec -d "$i" ipfs daemon
	done
}

uploadBlock(){
	BLOCK_HASH=$(docker exec "$1" ipfs add "$2")
	echo "$BLOCK_HASH" | grep -o -P '(?<=added ).*(?=mychannel.block)'	
}

copyBlockToPeers(){
	for i in peer1.org1.example.com peer0.org2.example.com peer1.org2.example.com; do
		docker exec "$i" ipfs get -o $2 /ipfs/$1
	done
}

initIPFS
#sleep 1
PEER0_ORG1=$(createBootstrapNodeAddress peer0.org1.example.com)
PEER1_ORG1=$(createBootstrapNodeAddress peer1.org1.example.com)
PEER0_ORG2=$(createBootstrapNodeAddress peer0.org2.example.com)
PEER1_ORG2=$(createBootstrapNodeAddress peer1.org2.example.com)

# sleep 1
addBootstrapPeers peer0.org1.example.com "$PEER1_ORG1" "$PEER0_ORG2" "$PEER1_ORG2"
addBootstrapPeers peer1.org1.example.com "$PEER0_ORG1" "$PEER0_ORG2" "$PEER1_ORG2"
addBootstrapPeers peer0.org2.example.com "$PEER0_ORG1" "$PEER1_ORG1" "$PEER1_ORG2"
addBootstrapPeers peer1.org2.example.com "$PEER0_ORG1" "$PEER1_ORG1" "$PEER0_ORG2"
sleep 1
initializeSwarm
sleep 1

BLOCK_HASH=$(uploadBlock peer0.org1.example.com mychannel.block)
copyBlockToPeers $BLOCK_HASH mychannel.block


