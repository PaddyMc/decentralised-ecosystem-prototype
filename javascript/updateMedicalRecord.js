'use strict';

var request = require('request');

var options = {
  uri: 'http://localhost:3001/people/updateRecord',
  method: 'POST',
  json: {
    "key": "MedicalRecord3",
    "record": "The Black Lung"
  }
};

request(options, function (error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log("Updating " + body.key + " in the blockchain with " + body.record)
  }
});
