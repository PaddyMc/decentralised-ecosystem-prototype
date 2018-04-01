module.exports = function(app){
    var people = require('./controllers/people');

/*	var cors = require('cors')

    var corsOptions = {
		origin: "*"
	}*/

    app.get('/people', people.findAll);
    app.get('/people/:query', people.findByQuery);
    app.post('/people/addPerson', people.addPerson);
    app.post('/people/updateRecord', people.updateRecord);
}
