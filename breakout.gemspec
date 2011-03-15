# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "breakout/version"

Gem::Specification.new do |s|
  s.name        = "breakout"
  s.version     = Breakout::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Steve Masterman"]
  s.email       = ["steve@vermonster.com"]
  s.homepage    = ""
  s.summary     = %q{Easy WebSockets in Ruby}
  s.description = %q{Easy WebSockets in Ruby}

  s.rubyforge_project = "breakout"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
