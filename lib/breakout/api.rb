module Breakout
  module Worker
    module API

      # The breakout server API for workers

      # commands are symbols :send_messages, :disconnect, :done_work
      # commands are sent to breakout server as a hash :command => args
      # args are 
      #   :done_work => requeue? #true or false whether to put worker back on work queue
      #   :send_messages => { message => [bid1, bid2, ...] }
      #   :disconnect => bid
      #
      # for messages incoming from the server (in worker.do_work) the notify api
      #  (if the browser url included notify=true) 
      #  when the browser socket opens, the message will be "/open\n"
      #  when the browser socket closes, the mesage will be "/close\n"

      def disconnect(bid)
        socket.send :disconnect => bid
      end

      def send_messages(args)
        raise Exception unless args.is_a?(Hash)
        socket.send :send_messages => args
      end

      alias send_message send_messages

      def done_work(requeue=true)
        socket.send :done_work => requeue
      end

    end
  end
end
