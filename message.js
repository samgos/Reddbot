

var WebClient = require('@slack/client').WebClient;

var token = process.env.SLACK_API_TOKEN || 'API_KEY' ;

var web = new WebClient(token)

var RtmClient = require('@slack/client').RtmClient;
var RTM_EVENTS = require('@slack/client').RTM_EVENTS;
var rtm = new RtmClient(token);
rtm.start();

rtm.on(RTM_EVENTS.TEAM_JOIN, function handleRtmTeamJoin(newmem){ console.log(newmem);
web.chat.postMessage('#general',"Welcome <@" + newmem.user.id + "> , I am reddbot. The channels's tipbot to find out more say: reddbot help ",
   {
     username: 'reddbot',
     icon_emoji: ':reddcoin:',
         },
function(err, res) {
  if (err) {
    console.log('Error:', err);
  } else {
    console.log('Message sent: ', res);
}
})});

rtm.on(RTM_EVENTS.MESSAGE, function handleRtmMessage(message) {
  if (message.text === "reddbot") {
    var channel = "#test";

web.chat.postMessage(message.user,"Hello <@" + message.user + ">, how can I help you? ",
   {
     username: 'reddbot',
     icon_emoji: ':reddcoin:',
         },
function(err, res) {
  if (err) {
    console.log('Error:', err);
  } else {
    console.log('Message sent: ', res);
}
});

