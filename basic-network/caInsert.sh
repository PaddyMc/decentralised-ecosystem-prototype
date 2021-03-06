cd ./crypto-config/peerOrganizations/org1.example.com/ca/
for f in "$dir"*_sk; do
  FILE="$f"
done
cd ../../../../

sed -i -e "s/--ca.keyfile \/etc\/hyperledger\/fabric-ca-server-config\/.*_sk/--ca.keyfile \/etc\/hyperledger\/fabric-ca-server-config\/$FILE/g" ./docker-compose.yml
