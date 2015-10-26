class GameSocket
  def get_reply
    #@reply = nil
    Console.log("waiting for reply...")
    thr = Thread.new do
      @reply = @socket.recv(Message_Length).rstrip
      Console.log("reply received: #{@reply}")
    end
    # wait up to 1 second for response
    # if thr.join(1)
    # Console.log("reply received: #{@reply}\n")
    # return @reply
    # else
    # thr.kill
    # Console.log("no reply received")
    # return nil
    # end
  end

  def send_message(msg)
    Console.log("sending message: #{msg}")
    @request = msg.ljust(Message_Length).slice(0, Message_Length - 1)
    @socket.send(@request) #, 0)
    Console.log("message sent")
  end
end
