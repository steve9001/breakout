module Breakout
  # The breakout server API for workers

  # commands are symbols :send_messages, :close_socket
  # commands are sent to breakout server as a hash :command => args
  # args are 
  #   :done_work => true
  #   :send_messages => { message => [id1, id2, ...] }
  #   :disconnect => id
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
