module Breakout

  WORKER_BY_ROUTE = {}

  module Worker
    def self.included(base)
      base.class_eval do
        include(WorkerAPI)
        include(Singleton)
      end
      raise Exception if WORKER_BY_ROUTE[base.name.downcase]
      WORKER_BY_ROUTE[base.name.downcase] = base.instance
    end
  end

  #first line of message is route
  #second line of message is bid
  def Breakout.dispatch(data)
    route, bid, message = data.split("\n", 3)
    raise "#{route}\n#{bid}\n#{message}" unless worker = WORKER_BY_ROUTE[route]
    worker.do_work(bid, message)
  end

  def Breakout.start_worker(url=nil)
    Breakout.extend WorkerAPI
    unless url
      url = Breakout.worker_url
    end
    
    $bs = Socket.new(url)

    while data = $bs.receive() do
      Breakout.dispatch(data)
      done_work
    end
  end
end
