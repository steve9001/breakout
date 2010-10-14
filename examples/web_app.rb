# rvm use ree@sinatra

require 'rubygems'
require 'sinatra'
require File.expand_path("../../brconfig", __FILE__)

layout = <<-APP
<!DOCTYPE html>
<html>
  <head>
   <title>Example</title>
  </head>
  <body>
    %s
  </body>
</html>
APP

get '/' do
  layout % <<-HTML
<h1><a href="/echo">Echo</a></h1>
<h1><a href="/ping">Ping</a></h1>
<h1><a href="/chat">Chat</a></h1>
HTML
end

get '/echo' do
  layout % <<-SCRIPT
<script type='text/javascript' src='/javascripts/jquery-1.4.2.min.js'></script>
<script type='text/javascript'>
var echo_url = '#{Breakout.browser_url('echo')}';
jQuery.getScript("/javascripts/echo.js");
</script>
SCRIPT
end

get '/ping' do
  layout % <<-SCRIPT
<script type='text/javascript' src='/javascripts/jquery-1.4.2.min.js'></script>
<script type='text/javascript'>
jQuery.getScript("/javascripts/ping.js", function() { new Ping('#{Breakout.browser_url('ping')}'); });
</script>
SCRIPT
end

