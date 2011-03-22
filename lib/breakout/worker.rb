module Breakout
  module Worker
    WORKERS = Array.new

    def self.included(base)
      WORKERS << base

      base.class_eval do
        include(API)
        attr_accessor :socket
      end

      base.instance_eval do
        def route
          name.downcase
        end
      end
    end
  end
end
