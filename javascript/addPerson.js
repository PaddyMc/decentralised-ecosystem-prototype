'use strict';

var request = require('request');

var fs = require('fs');
function readFile(filePath){
  return fs.readFileSync(filePath).toString();
}

var image = readFile('./tempImage.txt');

var options = {
  uri: 'http://localhost:3001/people/addPerson',
  method: 'POST',
  json: {
    "name": "CAR28",
    "image": image
  }
};

request(options, function (error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log("Adding " + body.name + " to the blockchain.")
  }
});
