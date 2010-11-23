function Chat() {
  
  var ws;
  
  var div = $("<div></div>");
  var ml = $("<ul style='list-style-type:none'></ul>");
  var mdiv = $("<div style='width:50%; margin:20px; padding:20px; border-style:solid; height:80%;'></div>");
  var idiv = $("<div contenteditable='true' style='width:50%; margin:20px; padding:20px; border-style:solid; border-color:blue;'></div>");

  this.onmessage = function(e) {
    ml.append("<li>" + e.data + "</li>");
  }

  ws = new WebSocket(chat_url);
  ws.onmessage = this.onmessage;
  ws.onclose = function(e) {
    ml.append("<li style='color:red;'>Disconnected from server.</li>");
  }

  mdiv.append(ml);
  div.append(mdiv);
  div.append(idiv);
  $('body').append(div);

  idiv.keyup(function(e) {
    if(e.keyCode == 13) {
    ws.send(idiv.text());
    idiv.text("");
    }
  });
    
  idiv.focus();

}
new Chat();
