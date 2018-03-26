'use strict';
var Fabric_Client = require('fabric-client');
var path = require('path');
var util = require('util');
var os = require('os');

exports.find = function(req, res) {

	var fabric_client = new Fabric_Client();

	var channel = fabric_client.newChannel('mychannel');
	var peer = fabric_client.newPeer('grpc://localhost:7051');
	channel.addPeer(peer);

	//
	var member_user = null;
	var store_path = path.join(__dirname, '../hfc-key-store');
	console.log('Store path:'+store_path);
	var tx_id = null;

	Fabric_Client.newDefaultKeyValueStore({ path: store_path
	}).then((state_store) => {
		fabric_client.setStateStore(state_store);
		var crypto_suite = Fabric_Client.newCryptoSuite();
		var crypto_store = Fabric_Client.newCryptoKeyStore({path: store_path});
		crypto_suite.setCryptoKeyStore(crypto_store);
		fabric_client.setCryptoSuite(crypto_suite);

		return fabric_client.getUserContext('user2', true);
	}).then((user_from_store) => {
		if (user_from_store && user_from_store.isEnrolled()) {
			console.log('Successfully loaded user1 from persistence');
			member_user = user_from_store;
		} else {
			throw new Error('Failed to get user1.... run registerUser.js');
		}

		// queryCar chaincode function - requires 1 argument, ex: args: ['CAR4'],
		// queryAllCars chaincode function - requires no arguments , ex: args: [''],
		const request = {
			//targets : --- letting this default to the peers assigned to the channel
			chaincodeId: 'fabcar',
			fcn: 'queryAllCars',
			args: ['']
		};
		return channel.queryByChaincode(request);
	}).then((query_responses) => {
		console.log("Query has completed, checking results");
		// query_responses could have more than one  results if there multiple peers were used as targets
		if (query_responses && query_responses.length == 1) {
			if (query_responses[0] instanceof Error) {
				console.error("error from query = ", query_responses[0]);
			} else {
				res.send([query_responses[0].toString()]);
				console.log("Response is ", query_responses[0].toString());
			}
		} else {
			console.log("No payloads were returned from query");
		}
	}).catch((err) => {
		console.error('Failed to query successfully :: ' + err);
	});


};

exports.add = function() {};

exports.findByQuery = function(req, res) {
	console.log(req.params.query)
};
