var ddb = require('dynamodb').ddb({ accessKeyId: 'AKIAJQNTOEJAQKEP4EXA',
                                    secretAccessKey: '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',
                                    endpoint: "dynamodb.us-east-1.amazonaws.com" });
var app = require('express')();

// "        "
// var database = { score: 0 };

app.get('/', (req, res) => {
    res.send("hello");
});

app.get('/get-SongValue', (req, res) => {
  ddb.getItem('SoundFinal', 'WhichSong', null, {},
    function(err, dynamoResult, cap) {
       console.log(req.query.SongValue);
      res.send(dynamoResult);
  });
});

app.get('/set-SongValue', (req, res) => {
   console.log(req.query.SongValue);
  var newData = {
   "SoundServer" : "WhichSong",
    SongValue: parseInt(req.query.SongValue)
  }
   console.log(parseInt(req.query.SongValue));
  
  ddb.putItem('SoundFinal', newData, {},
    function(err, dynamoResult, cap) {
      res.send({SongValue: newData.SongValue});
    });
});

// app.listen(process.env.PORT || 3000);
app.listen(3000);
// here is keep checking the changes on AWS, and passing this number to of to control music
setInterval(function() {
  ddb.getItem('SoundFinal', 'WhichSong', null, {},
    function(err, dynamoResult, cap) {
    	console.log(dynamoResult);
  });
}, 1000);







