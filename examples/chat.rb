require File.expand_path("../../lib/breakout", __FILE__)

class Chat

  include Breakout::Worker
  
  $members = Hash.new #move this to shared storage (e.g. Redis) for more than one worker process

  def do_work(sender, message)
    if message.start_with? "/open\n"
      unless $members.key?(sender)
        $members[sender] = true
        send_message "#{sender} has joined." => $members.keys
      end
    elsif message.start_with? "/close\n"
      if $members.delete(sender)
        disconnect sender
        send_message "#{sender} has left." => $members.keys
      end
    elsif $members.key?(sender) and message != ''
      send_message "#{sender}: #{message}" => $members.keys
    end
  end

end
