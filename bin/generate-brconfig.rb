#!/usr/bin/env ruby

# Generate a unique key configuration file for workers and web app.
# use Breakout.worker_url() for worker socket connection url
# use Breakout.browser_url(outlet) for unique browser connection url

config_filename = 'brconfig.rb'
breakout_host = ARGV[0] || 'localhost'
worker_port = 9000
browser_port = 9001

if File.exist?(config_filename)
  puts "Replacing #{config_filename}!"
end

puts "Generating #{config_filename}..."

require 'digest'
grid = (Digest::SHA2.new << rand.to_s).to_s[0..4]
grid_key = (Digest::SHA2.new << rand.to_s).to_s[0..30]

config_file = <<-BRCONFIG
require 'digest'
module Breakout
  module Config

    def grid
      "#{grid}"
    end

    def grid_access_token(outlet, bid, e, notify)
      (Digest::SHA2.new << "#{grid_key}#\{outlet}#\{bid}#\{e}#\{notify}").to_s
    end

    def worker_url()
      %|ws://#{breakout_host}:#{worker_port}/#{grid}?grid_key=#{grid_key}|
    end

    def bid()
      (Digest::SHA2.new << rand.to_s[0..10]).to_s
    end

    def browser_url(outlet, opts={})
      raise Exception unless outlet 
      bid = opts[:bid] || Breakout.bid
      e = opts[:e] || (Time.now + 3).to_i
      notify = opts[:notify] || false
      "ws://#{breakout_host}:#{browser_port}/#{grid}?outlet=#\{outlet}&bid=#\{bid}&e=#\{e}&notify=notify&gat=#\{grid_access_token(outlet, bid, e, notify)}"
    end

  end
  Breakout.extend Config
end
BRCONFIG

File.open(config_filename, 'w') do |f|
  f.write config_file
end
