#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'

#require 'breakout'
require File.expand_path("../../lib/breakout", __FILE__)
Breakout.load_or_create_config_file('breakout.yml')

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

get '/chat' do
  layout % <<-SCRIPT
<div>
  <h2>Name</h2>
  <form action="/chat" method="post">
  <input type="text" name="name" />
  <input type="submit" name="submit" />
  </form>
</div>
SCRIPT
end

post '/chat' do
  halt 400 unless name = params[:name]
  chat_url = Breakout.browser_url('chat', :bid => name, :notify => true)
  layout % <<-SCRIPT
<script type='text/javascript' src='/javascripts/jquery-1.4.2.min.js'></script>
<script type='text/javascript'>
var chat_url = '#{chat_url}';
jQuery.getScript("/javascripts/chat.js");
</script>
SCRIPT
end

