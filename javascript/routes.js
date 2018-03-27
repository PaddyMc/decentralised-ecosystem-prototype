module.exports = function(app){
    var people = require('./controllers/people');

    app.get('/people', people.findAll);
    app.get('/people/:query', people.findByQuery);
    app.post('/people/addPerson', people.addPerson);
}
