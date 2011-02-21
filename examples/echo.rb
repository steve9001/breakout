class Echo

  include Breakout::Worker
  
  def do_work(sender, message)
    #echo the message back
    send_message message => [sender,]
  end

end
