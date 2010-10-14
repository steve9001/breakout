
function Ping(ping_url) {
  
  var ws;
  var time;
  var spawn_url = null;
  var div = $("<div style='float:left; width:80px; margin:10px; padding:3px; text-align:center; border-style:solid;'></div>");

  var ping = function() {
    time = new Date();
    ws.send("ping");
  }

  this.onopen = function() {
    ping();
  }

  this.onmessage = function(e) {
    div.text((new Date() - time)/1000);
    setTimeout(ping, 1000);
    if (!spawn_url) {
      spawn_url = jQuery.parseJSON(e.data);
      setTimeout(function() {new Ping(spawn_url);}, 1500);
    }
  }

  ws = new WebSocket(ping_url);
  ws.onopen = this.onopen;
  ws.onmessage = this.onmessage;

  div.text('0');
  $('body').append(div);

}
