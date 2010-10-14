dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'singleton'
require 'json'
require 'breakout/web_socket'

module Breakout
  require 'lib/breakout/railtie' if defined?(Rails)
  require 'breakout/socket'
  require 'breakout/server_api'
  require 'breakout/worker'
end
