'use strict';
var express = require('express');
var app = express();

require('./routes')(app);

app.listen(3001);
console.log("Jammin\' on port 3001...");