module Breakout
  module Worker
    class App
      
      include API
      attr_accessor :worker_by_route, :socket, :stop

      def dispatch(data)
        route, bid, message = data.split("\n", 3)
        raise "#{route}\n#{bid}\n#{message}" unless worker = worker_by_route[route]
        worker.do_work(bid, message)
      end

      def run(url=nil)
        unless url
          url = Breakout.worker_url
        end
        
        self.socket = Socket.new(url)
        self.worker_by_route = Hash.new
        Worker::WORKERS.each do |klass|
          worker = klass.new
          worker.socket = socket
          worker_by_route[klass.route] = worker
        end

        done_work
        while data = socket.receive() do
          dispatch(data)
          if @stop
            done_work false
            break
          end
          done_work
        end

      end
    end

  end
end
