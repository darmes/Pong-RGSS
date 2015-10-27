#==============================================================================
# ** Game_Socket
#------------------------------------------------------------------------------
#  This class contains methods common to both GameServer and GameClient
#==============================================================================

class GameSocket

	#--------------------------------------------------------------------------
	# * Include configuration parameters
	#--------------------------------------------------------------------------
	include Mobius::Multiplayer

	#--------------------------------------------------------------------------
	# * Get Reply - gets a message from the connected socket
	#--------------------------------------------------------------------------
  def get_reply
    Console.log("waiting for reply...")
    Thread.new do
      @reply = @socket.recv(Message_Length).rstrip
      Console.log("reply received: #{@reply}")
    end
  end
	#--------------------------------------------------------------------------
	# * Send Message - sends a message to the connected socket
	#--------------------------------------------------------------------------
  def send_message(msg)
    Console.log("sending message: #{msg}")
    @request = msg.ljust(Message_Length).slice(0, Message_Length - 1)
    @socket.send(@request) #, 0)
    Console.log("message sent")
	end
	#--------------------------------------------------------------------------
	# * Pack Message - Takes an array of game data and converts it to string form
	#     arr = [paddle_left_y,paddle_right_y,ball_x,ball_y,score_left,score_right]
	#     convert to "000,000,000,000,000,000,"
	#--------------------------------------------------------------------------
	def pack_message(arr)
		return arr.collect { |x| sprintf("%03d", x) }.join(",") + ","
	end
	#--------------------------------------------------------------------------
	# * Unpack Message - Takes an string of game data and converts it to array form
	#     str = "000,000,000,000,000,000,"
	#     convert to [paddle_left_y,paddle_right_y,ball_x,ball_y,score_left,score_right]
	#--------------------------------------------------------------------------
	def unpack_message(str)
		return str.split(",").collect { |x| x.to_i }
	end
	#--------------------------------------------------------------------------
	# * Send Test - sends a test message to the connected socket
	#--------------------------------------------------------------------------
	def send_test
		send_message '000,000,000,000,000,000,'
	end
end
