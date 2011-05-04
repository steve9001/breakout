class Chat

  include Breakout::Worker
  
  def initialize
    @redis = Redis.new
  end

  def members
    @redis.smembers "chat_members"
  end

  def member?(bid)
    @redis.sismember "chat_members", bid
  end

  def add(bid)
    @redis.sadd "chat_members", bid
  end

  def delete(bid)
    @redis.srem "chat_members", bid
  end

  def do_work(sender, message)
    if message.start_with? "/open"
      unless member? sender
        add sender
        send_message "#{sender} has joined." => members
      end
    elsif message.start_with? "/close"
      if member? sender
        delete sender
        disconnect sender
        send_message "#{sender} has left." => members
      end
    elsif message != ''
      send_message "#{sender}: #{message}" => members
    end
  end

end
