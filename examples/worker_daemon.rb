#!/usr/bin/env ruby

require File.expand_path("../../lib/breakout", __FILE__)

Breakout.load_or_create_config_file('breakout.yml')

['ping', 'echo', 'chat'].each do |worker|
  require File.expand_path("../#{worker}", __FILE__)
end

Breakout.start_worker()

