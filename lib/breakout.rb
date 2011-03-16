dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'singleton'
require 'json'
require 'yaml'
require 'breakout/web_socket'

module Breakout
  require 'breakout/config'
  require 'lib/breakout/railtie' if defined?(Rails)
  require 'breakout/socket'
  require 'breakout/worker_api'
  require 'breakout/worker'
end
