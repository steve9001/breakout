class Ping

  include Breakout::Worker
  
  def do_work(sender, message)
    send_message Breakout.browser_url('ping')  => [sender, ]
  end

end
