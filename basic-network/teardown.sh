#!/bin/bash
# Exit on first error, print all commands.
set -e

# Shut down the Docker containers for the system tests.
docker-compose -f docker-compose.yml stop
sleep 3
docker rm -f $(docker ps -aq)
sleep 3
./teardown.sh
docker-compose -f docker-compose.yml kill
docker-compose -f docker-compose.yml down

# remove the local state
rm -f ~/.hfc-key-store/*

# remove chaincode docker images
docker rmi $(docker images dev-* -q)

# remove auto generated files
rm -rf ./crypto-config
rm -rf channel-artifacts
mkdir channel-artifacts
