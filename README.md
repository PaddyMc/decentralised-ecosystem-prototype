# decentralised-ecosystem-prototype

<body>

<h1>Prerequisites</h1>
<p>Have configtxgen and cryptogen in $PATH</p>

<h1>To start</h1>
<p>Navigate to the /basic-network folder with CLI</p>
  <p>Run commands:</p>
    <ul>
        <li>./start.sh</li>
    </ul>
   <p>This spins up the distributed ledger and installs a chaincode contract</p>
<h1>Interact with js</h1>
<p>Navigate to the /javascript folder with CLI</p>
<p>Run commands:</p>
    <ul>
        <li>node enrollAdmin.js</li>
        <li>node registerUser.js</li>
        <li>node server.js</li>
    </ul>
<p>URL: http://localhost:3001/people/updateRecord</p>
<p>URL: http://localhost:3001/people/addPerson</p>
<p>URL: http://localhost:3001/image/:query</p>
<p>URL: http://localhost:3001/record/:query</p>
<h1>To exit</h1>
<p>Navigate to the /basic-network folder with CLI</p>
  <p>Run commands:</p>
    <ul>
        <li>./teardown.sh</li>
    </ul>
</body>

<h1>For Demo</h1>
<h2>./generateCerts.sh</h2>
  <ul>
	  <li>Config for consensus is passed here</li>
	  <li>Config is then used by go program running on orderer machine</li>
	  <li>Generating certs for machines to communicate</li>
	</ul>
<h2>./startBlockchain.sh</h2>
  <ul>
	  <li>Spins up all machines needed to simulate Blockchain (4 peers, 1 orderer, 1 Cert auth, 1 tools)</li>
	  <li>Creates genesis block (is used to connect to the network)</li>
	  <li>Connects peer0 to orderer</li>
  </ul>
<h2>./ipfsConfig.sh</h2>
  <ul>
	  <li>Creates private ipfs network</li>
	  <li>Transfers genesis.block to every peer so they can connect</li>
  </ul>
	
<h2>./addPeers.sh</h2>
  <ul>
	  <li>adds every peers to the distributed network</li>
	  <li>at this point we have a distributed ledger, but no way to interact as no smart contract</li>
  </ul>

<h2>./invokeSmartcontract.sh</h2>
  <ul>
	  <li>installs smartcontract on all peers</li>
	  <li>instanisates the smart contract on the orderer</li>
	  <li>queries the orderer from all peers</li>
  </ul>
	

