module Breakout
  # The breakout server API for workers

  # commands are symbols :send_messages, :disconnect, :done_work
  # commands are sent to breakout server as a hash :command => args
  # args are 
  #   :done_work => true
  #   :send_messages => { message => [id1, id2, ...] }
  #   :disconnect => id
  #
  # for messages incoming from the server (in worker.do_work) the notify api
  # (if the browser url included notify=true) 
  # when the browser socket opens, the message will be "/open\n"
  # when the browser socket closes, the mesage will be "/close\n"

  module ServerAPI

    def disconnect(id)
      $bs.send :disconnect => id
    end

    def send_messages(args)
      raise Exception unless args.is_a?(Hash)
      $bs.send :send_messages => args
    end

    alias send_message send_messages

    def done_work
      $bs.send :done_work => true
    end

  end
end
