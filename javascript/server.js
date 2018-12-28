'use strict';
var express = require('express');
var bodyParser = require('body-parser');
//var cors = require('cors')
var app = express();

// app.use(express.bodyParser({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json())
//app.use(cors())

require('./routes')(app);

app.listen(3001);
console.log("Jammin\' on port 3001...");
