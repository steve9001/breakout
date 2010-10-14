module Breakout

  OUTLETS = {}

  module Worker
    def self.included(base)
      base.class_eval do
        include(ServerAPI)
        include(Singleton)
      end
      raise Exception if OUTLETS[base.name.downcase]
      OUTLETS[base.name.downcase] = base.instance
    end
  end

  #first line of message is outlet name
  #second line of message is bid
  #rest is for the outlet
  def Breakout.dispatch(data)
    outlet_name, bid, message = data.split("\n", 3)
    unless outlet = OUTLETS[outlet_name]
      disconnect bid
      return
    end
    outlet.do_work(bid, message)
  end

  def Breakout.start_worker(url=nil)
    Breakout.extend ServerAPI
    unless url
      url = Breakout.worker_url
    end
    
    puts url.inspect
    $bs = Socket.new(url)

    while data = $bs.receive() do
      Breakout.dispatch(data)
      done_work
    end
  end
end
