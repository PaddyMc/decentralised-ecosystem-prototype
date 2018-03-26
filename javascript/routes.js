module.exports = function(app){
    var people = require('./controllers/people');
    app.get('/people', people.find);
    app.get('/people/:query', people.findByQuery);
    app.post('/people', people.add);
    // app.get('/enrollAdmin', people.enrollAdmin);
    // app.get('/registerUser', people.registerUser);
}
