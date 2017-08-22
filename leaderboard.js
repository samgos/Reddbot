var capcon = require('capture-console');
var WebClient = require('@slack/client').WebClient;

var token = process.env.SLACK_API_TOKEN || 'API_KEY' ;

var web = new WebClient(token)
var RtmClient = require('@slack/client').RtmClient;
var RTM_EVENTS = require('@slack/client').RTM_EVENTS;
var rtm = new RtmClient(token);
rtm.start();

rtm.on(RTM_EVENTS.MESSAGE, function handleRtmMessage(message) {
  if (message.text === "reddbot leaderboard"|message.text === "Reddbot leaderboard") {
    var channel = "#general";

web.search.messages('Give a little to get a little, they do say? from:reddbot',
        {
count: '10',
        },
function(err, res) {
  if (err) {
    console.log('Error:', err);
  } else {
    console.log('Message sent: ', res);

var dict_tips = [];
var dict_counts = [];
var users = []
var score = []
var board = []
var freq = []
var tip_top = []
for (var i = 0; i < 10 ; i++)                                          {
var str = res.messages.matches[i].text;
var stdout = capcon.captureStdout(function scope() {
for (var x = 46 ; x < 55 ; x++) {
process.stdout.write(str[x]);
                                }
                                                });
var id = JSON.stringify(stdout.match(/.{1,9}/g))
var id =  ( "" + id.slice(2,11)).replace(/. /g,'');
var stdout = capcon.captureStdout(function scope() {
for (var x = 76 ; x < 85 ; x++) {
process.stdout.write(str[x]);
                                }                       });
var extract = JSON.stringify(stdout.match(/.{0,9}/g));
var parse = extract.indexOf(/.RDD|RD|R|D|:| |r|e/g)
if (parse = -1)
{
var format = ( "" + extract.slice(2,9)).replace(/.RDD|RD|R|D|:| |r|e/g,'');
}
else
{
var format = extract.slice(2,9)
}
var x = checkAndAdd(id,format)
function checkAndAdd(id,format) {
  var found = dict_tips.some(function (el) {
    return el.key === id;  })
if (!found) {
                var x = format.substr(0, 9) + " " + format.substr(9);
                dict_tips.push({key: id})
                dict_counts.push({key: id})
                var total = x.split(" ")
                dict_tips[id] = "";
                dict_tips[id] += total
                users.push(id)
                dict_counts[id] = "";
                dict_counts[id] += 1 + ",";
                }
        else
        {
                var x = format.substr(0, 9) + " " + format.substr(9)
                var total = x.split(" ")
                dict_tips[id] += total
                dict_counts[id] += 1 + ",";
        }




}


}
    
for (var x = 0 ; x < dict_tips.length ; x++)
{
var key = users[x]
score.push(dict_tips[key])
}

const data = score

const sums = Object.keys(data).reduce((results, key) => {
  results[key] = (data[key] + '').split(',')
    .map(item => parseFloat(item))
    .filter(item => !isNaN(item))
    .reduce((res, item) => res + item, 0)

  return results
}, {})


for (var x = 0 ; x < dict_tips.length ; x++){
board.push(parseFloat(sums[x]))                 }

    var leader = Math.max.apply(Math, board);
var first = board.indexOf(parseFloat(leader));
board.splice(first,1,0)

var follower = Math.max.apply(Math, board);
var second =  board.indexOf(parseFloat(follower))
board.splice(second,1,0)

var bronze = Math.max.apply(Math, board);
var third =  board.indexOf(parseFloat(bronze))
board.splice(third,1,0)

var four = Math.max.apply(Math, board);
var fourth =  board.indexOf(parseFloat(four))
board.splice(fourth,1,0)

var five = Math.max.apply(Math, board);
var fifth =  board.indexOf(parseFloat(five))
board.splice(fifth,1,0)

var six = Math.max.apply(Math, board);
var sixth =  board.indexOf(parseFloat(six));
board.splice(sixth,1,0)

var seven = Math.max.apply(Math, board);
var seventh =  board.indexOf(parseFloat(seven));
board.splice(seventh,1,0)

var eight = Math.max.apply(Math, board);
var oct  =  board.indexOf(parseFloat(eight));
board.splice(oct,1,0)

var nine = Math.max.apply(Math, board);
var nes  =  board.indexOf(parseFloat(nine));


for (var x = 0 ; x < dict_counts.length ; x++)
{
var key = users[x]
freq.push(dict_counts[key])
}

const dataz = freq

const tipper = Object.keys(dataz).reduce((results, key) => {
  results[key] = (dataz[key] + '').split(',')
    .map(item => parseInt(item))
    .filter(item => !isNaN(item))
    .reduce((res, item) => res + item, 0)

  return results
}, {})

for (var x = 0 ; x < dict_counts.length ; x++){
tip_top.push(parseInt(tipper[x]))                 }

var recent = Math.max.apply(Math, tip_top);
var location = tip_top.indexOf(parseInt(recent));
tip_top.splice(location,1,0)

var recent2 = Math.max.apply(Math, tip_top);
var location2 = tip_top.indexOf(parseInt(recent2));
tip_top.splice(location2,1,0)

var recent3 = Math.max.apply(Math, tip_top);
var location3 = tip_top.indexOf(parseInt(recent3));

var attach =                    [{
                                   title: 'Leaderboard',
                                   fields: [{
                                              value: "1. <@" + users[first].slice(0,11) + ">  Tipped: " + leader + " RDD :reddcoin:"},
                                             {value: "2. <@" + users[second].slice(0,11) + ">  Tipped: " + follower + " RDD :reddcoin:"},
                                             {value: "3. <@" + users[third].slice(0,11) + ">  Tipped: " + bronze + " RDD :reddcoin:"},
                                             {value: "4. <@" + users[fourth].slice(0,11) + ">  Tipped: " + four + " RDD :reddcoin:"},
                                             {value: "5. <@" + users[fifth].slice(0,11) + ">  Tipped: " + five + " RDD :reddcoin:"},
                                             {title: "Upcoming Tippers",
                                             value:  "<@" + users[sixth].slice(0,11) + ">,<@" + users[seventh].slice(0,11) + ">,<@" + users[oct].slice(0,11) + ">",
                                             short: 'true'},
                                             {title: "Most Frequent Tippers",
                                             value:  "<@" + users[location].slice(0,11) + ">,<@" + users[location2].slice(0,11) + ">,<@" + users[location3].slice(0,11) + "> ",
                                             short: 'true'}
                                        ],
                                   color: '#2BB24B'}]

var table =  JSON.stringify(attach)
                                              
web.chat.postMessage(message.channel,'Tip to win a name amongst the elite.',
   {
     username: 'reddbot',
     icon_emoji: ':reddcoin:',
     attachments: table,

         },
function(err, res) {
  if (err) {
    console.log('Error:', err);
  } else {
    console.log('Message sent: ', res);

}
}); //line 118

}
});


}
});


