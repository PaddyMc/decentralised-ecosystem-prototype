module.exports = function(app){
    var people = require('./controllers/people');

    app.get('/record/:query', people.findRecord);
    app.get('/image/:query', people.findImage);
    app.post('/people/addPerson', people.addPerson);
    app.post('/people/updateRecord', people.updateRecord);
}
