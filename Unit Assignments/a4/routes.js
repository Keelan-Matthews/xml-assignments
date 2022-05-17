let router = (app,fs) => {
    let data_file = 'data.json';

    app.get('/data', (req,res) => {
        fs.readFile(data_file, (err, data) => {
            if (err) throw err;
            res.send(JSON.parse(data));
        });
    });

    app.get('/data/:id', (req,res) => {
        let idReq = req.params["id"];
        fs.readFile(data_file, (err, data) => {
            if (err) throw err;
            let json = JSON.parse(data);
            let filtered = json.filter(e => e.id == idReq);
            res.send(filtered);
        });
    });

    app.post('/data', (req, res) => {
        fs.readFile(data_file, (err, data) => {
            if (err) throw err;
            let json = JSON.parse(data);

            json[json.length] = req.body;
            let newData = JSON.stringify(json);

            fs.writeFile(data_file, newData, (err, data) =>{
                if (err) throw err;
            });

            res.send(json);
        });

    });

    app.put('/data/:id', (req, res) => {
        let data_file = 'data.json';
        let idReq = req.params["id"];
        fs.readFile(data_file, (err, data) => {
            if (err) throw err;
            let json = JSON.parse(data);

            index = json.findIndex((e => e.id == idReq));
            json[index] = req.body;

            let newdata = JSON.stringify(json);
            fs.writeFile(data_file, newdata, (err) =>{
                if (err) throw err;
            });

            res.send(json);
        });
    });

    app.delete('/data/:id', (req, res) => {
        let data_file = 'data.json';
        let idReq = req.params["id"];
        fs.readFile(data_file, (err, data) => {
            if (err) throw err;
            let json = JSON.parse(data);
            index = json.findIndex((e => e.id == idReq));
            json.splice(index,1);

            let newdata = JSON.stringify(json);
            fs.writeFile(data_file, newdata, (err) =>{
                if (err) throw err;
            });

            res.send(json);
        });
    });
};

module.exports = router;