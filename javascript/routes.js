module.exports = function(app){
    var people = require('./controllers/people');
    app.get('/people', people.find);
    app.get('/people/:query', people.findByQuery);
    app.post('/people', people.add);
}