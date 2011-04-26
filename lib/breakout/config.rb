require 'digest'

module Breakout

  CONFIG = {}

  def self.random_config
    { 
      :breakout_host => 'localhost',
      :worker_port => 9001,
      :browser_port => 9002,
      :grid => (Digest::SHA2.new << rand.to_s).to_s[0..4],
      :grid_key => (Digest::SHA2.new << rand.to_s).to_s[0..30]
    }
  end

  def self.random_bid
    (Digest::SHA2.new << rand.to_s).to_s[0..10]
  end

  def self.config(opts={})
    CONFIG.merge!(opts)
  end

  def self.grid_access_token(route, bid, e, notify, grid_key=nil)
    grid_key ||= CONFIG[:grid_key]
    (Digest::SHA2.new << "#{grid_key}#{route}#{bid}#{e}#{notify}").to_s
  end

  def self.worker_url()
    "ws://#{CONFIG[:breakout_host]}:#{CONFIG[:worker_port]}/#{CONFIG[:grid]}?grid_key=#{CONFIG[:grid_key]}"
  end

  def self.browser_url(route, opts={})
    bid = opts[:bid] || random_bid
    e = opts[:e] || (Time.now + 3).to_i
    notify = opts[:notify] || false
    gat = grid_access_token(route, bid, e, notify)
    "ws://#{CONFIG[:breakout_host]}:#{CONFIG[:browser_port]}/#{CONFIG[:grid]}?route=#{route}&bid=#{bid}&e=#{e}&notify=#{notify}&gat=#{gat}"
  end

  def self.load_or_create_config_file(config_filename)
    unless File.exist?(config_filename)
      File.open(config_filename, 'w') do |f|
        f.write random_config.to_yaml
      end
    end
    config(YAML.load(File.open(config_filename, 'r')))
  end
end
