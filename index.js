const express = require('express')
const app = express()
const bodyParser = require('body-parser');

const port = 3001
var cors = require('cors')
app.use(cors())
// app.use(bodyParser.json());

let array = [];


app.get('/', (req, res) => {

  let payload = "<HTML><head>    <meta http-equiv=refresh content=5 /><head><Table border=1 cellpadding-1>"
  array.forEach(function(e) {
    payload =  payload + "<tr><th>"+e.student+ "</th><td>"+e.body+"</td><td>"+e.date+"</td></tr>";
  })
  payload =  payload + "</table></HTML>"
  res.send(payload)
})

app.get('/data', (req, res) => {

  res.send(array)
})
app.post('/', bodyParser.json(), (req, res) => {
  let body = req.body;
  let newbody = {}
  newbody.student = Object.keys(body)[0]
  newbody.body = body[newbody.student]
  newbody.date = new Date();
  console.log(newbody);
  array.unshift(newbody);
  res.send("Received")
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
