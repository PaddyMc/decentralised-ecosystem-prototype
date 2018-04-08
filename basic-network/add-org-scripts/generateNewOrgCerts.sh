#!/bin/sh

echo
echo "========== Generating crypto-config =========="
../cryptogen generate --config=./org3-crypto.yaml

echo
echo "========== Generating config 'org3.json' for Org3MSP =========="
export FABRIC_CFG_PATH=$PWD && ../configtxgen -printOrg Org3MSP > ../channel-artifacts/org3.json

echo
echo "========== Copying crypto-config for Org3MSP to basic-network crypto-config =========="
cd ../ && cp -r crypto-config/ordererOrganizations add-org-scripts/crypto-config/



