require "socket"
# GameClient needs to get player 1 paddle position and ball position
# GameClient needs to send player 2 paddle position
# Get message format: 000,000;000,000; # paddle_x,paddle_y;ball_x,ball_y
# Send message format: 000,000; # paddle_x,paddle_y

# Let's try instead to stream entire game from player 1 (server) to player 2 (client)
# Use paddle1_y, paddle2_y, ball_x, ball_y, score1, score2
# 000,000,000,000,000,000,

# Then we'll only have to upload player2's input
class GameClient

	include Mobius::Multiplayer
	Message_Length = 24
	
	# default port = 1990
	# default hostname = localhost
	def initialize(port = DEFAULT_PORT, hostname = DEFAULT_HOSTNAME)
		@socket = TCPSocket.new(hostname, port)
		@request = ""
		@reply = ""
		@input_state = ""
	end
	
	def update
		# every frame check input and send to server
		if Input.press?(Input::UP)
			@input_state = "up"
		eslif Input.press?(Input::DOWN)
			@input_state = "down"
		else
			@input_state = ""
		end
		send_message( pack_message(@input_state) )
		# every frame assume server is sending you data
		get_reply
	end
	
	def send_message(msg)
		Console.log("sending message: #{msg}...\n")
		@request = msg.ljust(Message_Length).slice(0,Message_Length - 1)
		@socket.send(@request, 0)
		Console.log("message sent\n")
	end
	
	def get_reply
		Console.log("waiting for reply...\n")
		thr = Thread.new do
			@reply = @socket.recv(Message_Length).rstrip
		end
		# wait up to 2 seconds for response
		# if thr.join(2)
			# Console.log("reply received: #{@reply}\n")
			# return @reply
		# else
			# thr.kill
			# Console.log("no reply received")
			# return nil
		# end
	end
	
	# arr = [paddle_x,paddle_y,ball_x,ball_y]
	# convert to "000,000,000,000,"
	def pack_message(arr)
		return arr.collect {|x| sprintf("%03d", x)}.join(",") + ","
	end
	
	# str = "000,000,000,000,"
	# convert to [paddle_x,paddle_y,ball_x,ball_y]
	def unpack_message(str)
		return str.split(",").collect {|x| x.to_i}
	end
	
	def send_test
		send_message "000,000,000,000,000,000,"
	end

end