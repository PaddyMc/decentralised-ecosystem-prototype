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

