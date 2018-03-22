#!/bin/bash
# Exit on first error, print all commands.

# Shut down the Docker containers for the system tests.
docker-compose -f docker-compose.yml stop
sleep 3
docker rm -f $(docker ps -aq)
sleep 3

docker-compose -f docker-compose.yml kill
docker-compose -f docker-compose.yml down

# remove chaincode docker images
docker rmi $(docker images dev-* -q)

# remove auto generated files
rm -rf ./crypto-config
rm -rf channel-artifacts/*
rm -rf ../javascript/hfc-key-store/*
