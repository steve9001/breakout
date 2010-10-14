function Echo() {
  
  var ws;
  
  var times = [];
  var div = $("<div></div>");
  var ddiv = $("<div style='width:50%; margin:20px; padding:20px; border-style:solid; border-color:red;overflow:auto;'></div>");
  var mdiv = $("<div style='width:50%; margin:20px; padding:20px; border-style:solid;'></div>");
  var idiv = $("<div contenteditable='true' style='width:50%; margin:20px; padding:20px; border-style:solid; border-color:blue;'></div>");

  var debug = function (content) {
    ddiv.append("<p>" + content + "</p>");
  }

  this.onopen = function() {
    debug("WebSocket opened");
  }

  this.onclose = function() {
    debug("WebSocket closing");
  }

  this.onmessage = function(e) {
    var t = (new Date() - times.shift())/1000;
    ddiv.text(t + " seconds"); 
    mdiv.append(String.fromCharCode(jQuery.parseJSON(e.data)));
  }

  ws = new WebSocket(echo_url);
  ws.onopen = this.onopen;
  ws.onclose = this.onclose;
  ws.onmessage = this.onmessage;

  div.append(ddiv);
  div.append(mdiv);
  div.append(idiv);
  $('body').append(div);

  idiv.keypress(function(e) {
    var code = (e.keyCode ? e.keyCode : e.which);
    ws.send(code);
    times.push(new Date());
  });
  
  idiv.focus();


}
new Echo();

