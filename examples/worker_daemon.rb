#!/usr/bin/env ruby
begin
  require File.expand_path("../../brconfig", __FILE__)
rescue LoadError
  puts `#{File.expand_path("../../bin/generate-brconfig.rb", __FILE__)}`
  require File.expand_path("../../brconfig", __FILE__)
end

require File.expand_path("../ping", __FILE__)
require File.expand_path("../echo", __FILE__)

Breakout.start_worker()

