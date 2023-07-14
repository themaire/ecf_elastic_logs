// STUDI ECF
// PUSH DATA TO ELASTICSEARCH INDEX
// Nicolas ELIE
// 2023/07/14

const PORT = 10000

const { Client } = require('@elastic/elasticsearch')

const CLOUDID = process.env.cloudID;
const USERNAME = process.env.username;
const PASSWORD = process.env.password;

const client = new Client({
  cloud: {
    id: CLOUDID
  },
  auth: {
    username: USERNAME,
    password: PASSWORD
  }
})

client.info()
  .then(response => console.log(response))
  .catch(error => console.error(error))


// Start express mini Elastic push data WEBAPP
http.createServer(app).listen(PORT);
app.get('/', function(req, res) {
    let date_ob = new Date();
    let calcTimeStamp = Math.floor(date_ob.getTime()/1000)

    let html = "Hello World!<br><br>";
    html += "This values will be sent to Elastic Cloud server for analyse the access of this page.<br>";
    html += "Date (string version)"+ date_ob.toString() + "<br><br></br>";
    html += "Timestamp date : " + Math.floor(date_ob.getTime()/1000) + "<br>";
    
    res.send( html );

    async function run() {
        await client.index({
            index: 'nestjs-infos-access',
            body: {
                host : req.get('host'),
                date : date_ob,
                date_string: date_ob.toString(),
                timestamp: calcTimeStamp
            }
        })
      
        await client.indices.refresh({index: 'nestjs-infos-access'})
    }

    console.log(calcTimeStamp)
    console.log(date_ob)
});