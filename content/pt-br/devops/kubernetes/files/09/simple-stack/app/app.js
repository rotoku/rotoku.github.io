import 'dotenv/config'
import express from 'express';
import mysql from 'mysql2';
import moment from 'moment';

const app = express();
const PORT = process.env.PORT || 3000;
const DB_URL = process.env.DB_URL || 'minhaurl.com.br';
const DB_PORT = process.env.DB_PORT || 3306;
const DB_NAME = process.env.DB_NAME || 'meu-banco';
const DB_USERNAME = process.env.DB_USERNAME || 'meu-usuario';
const DB_PASSWORD = process.env.DB_PASSWORD || 'minha-senha';


app.set("view engine", "ejs");
app.set("views", "./views");
app.use(express.json());

app.get("/", function(req, res){
    // const connection = mysql.createConnection({
    //     host: DB_URL,
    //     user: DB_USERNAME,
    //     password: DB_PASSWORD,
    //     database: DB_NAME,
    //     port: DB_PORT
    //   });

    //   connection.query('SELECT * FROM contatos', function (error, results, fields) {
    //     if (error) {
    //         console.log(error);
    //         res.send("Error occurred while fetching data");
    //     } else {
    //         res.render('contatos/index', { data: results, moment: moment });
    //     }
    // });      
    res.send("<h1>Hello World!</h1>");
});

app.listen(PORT, function(){
    console.log(`Servidor com express rodando na porta ${PORT}.`);
});