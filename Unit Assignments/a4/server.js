let express = require('express');
let bodyParser = require('body-parser');
let fs = require('fs');

let app = express();
app.use(bodyParser.json());
let routes = require('./routes.js')(app,fs);
app.use(bodyParser.urlencoded({extend:false}));

let port = process.env.PORT || 3000;
app.listen(port);
console.log('listening on port ' + port);

app.get('/', function (req, res) {
    res.send('Hello, world!');
})