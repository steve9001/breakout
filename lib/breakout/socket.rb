module Breakout
  #the global open breakout socket in this worker process
  $bs = nil
  class Socket < WebSocket
    def initialize(url)
      #WebSocket.debug = true
      @ws = WebSocket.new(url)
      $bs = self
    end

    def receive
      @ws.receive
    end

    def send(msg)
      if msg.is_a?(String)
        @ws.send(msg)
      else
        @ws.send(msg.to_json)
      end
    end

  end
end
