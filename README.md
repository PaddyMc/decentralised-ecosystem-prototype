# decentralised-ecosystem-prototype
decentralised-ecosystem-prototype that leverages ipfs and hyperledger fabric

Prerequisites:
Have configtxgen and cryptogen in $PATH

To start:
  Navigate to javascript folder
    Run commands:
      startFabric.sh
      npm install

To exit:
  Navigate to basic network folder: 
    Run commands:
      ./stop.sh
      ./teardown.sh
      docker rm -f $(docker ps -aq)
      docker network prune
      docker rmi dev-peer0.org1.example.com-fabcar-1.0-5c906e402ed29f20260ae42283216aa75549c571e2e380f3615826365d8269ba
     
