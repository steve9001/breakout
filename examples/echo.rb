require File.expand_path("../../lib/breakout", __FILE__)

class Echo

  include Breakout::Worker
  
  def do_work(sender, message)
    #echo the message back
    send_message message => [sender,]
  end

end
