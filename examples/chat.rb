class Chat

  include Breakout::Worker
  
  attr_accessor :members #move this to shared storage (e.g. Redis) for more than one worker process

  def initialize
    self.members = Hash.new
  end

  def do_work(sender, message)
    if message.start_with? "/open"
      unless members.key?(sender)
        members[sender] = true
        send_message "#{sender} has joined." => members.keys
      end
    elsif message.start_with? "/close"
      if members.delete(sender)
        disconnect sender
        send_message "#{sender} has left." => members.keys
      end
    elsif members.key?(sender) and message != ''
      send_message "#{sender}: #{message}" => members.keys
    end
  end

end
