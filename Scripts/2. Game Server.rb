require "socket"
# GameClient needs to get player 1 paddle position and ball position
# GameClient needs to send player 2 paddle position
# Get message format: 000,000;000,000; # paddle_x,paddle_y;ball_x,ball_y
# Send message format: 000,000; # paddle_x,paddle_y

# Let's try instead to stream entire game from player 1 (server) to player 2 (client)
# Use paddle1_y, paddle2_y, ball_x, ball_y, score1, score2
# 000,000,000,000,000,000,

# Then we'll only have to upload player2's input
# @reply = "up" or "down"
class GameServer

	include Mobius::Multiplayer
	Message_Length = 24
	
	attr_reader :reply
	
	# default port = 1990
	# default hostname = localhost
	def initialize(port = DEFAULT_PORT)
		@server = TCPServer.new(port)
		@socket = nil
		@request = ""
		# Initialize reply to nil
		@reply = nil
		# Create empty game_state array initialized to 0's
		@game_state = Array.new(6, 0) 
	end
	
	def accept_connection
		Thread.new do
			@socket = @server.accept
		end		
	end
	
	def update
		# every frame assume @game_state is good and send to client
		send_message( pack_message(@game_state) )
		# every frame assume client is sending you data
		get_reply
	end
	
	def send_message(msg)
		Console.log("sending message: #{msg}...\n")
		@request = msg.ljust(Message_Length).slice(0,Message_Length - 1)
		@socket.send(@request, 0)
		Console.log("message sent\n")
	end
	
	def get_reply
		#@reply = nil
		Console.log("waiting for reply...\n")
		thr = Thread.new do
			@reply = @socket.recv(Message_Length).rstrip
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
	
	def game_state=(game_state_hash)
		paddle1_y =  game_state_hash[:paddle1_y]
		paddle2_y =  game_state_hash[:paddle2_y]
		ball_x    =  game_state_hash[:ball_x]
		ball_y    =  game_state_hash[:ball_y]
		score1    =  game_state_hash[:score1]
		score2    =  game_state_hash[:score2]
	end
	
	def paddle1_y=(y)
		@game_state[0] = y
	end
	def paddle2_y=(y)
		@game_state[1] = y
	end
	def ball_x=(x)
		@game_state[2] = x
	end
	def ball_y=(y)
		@game_state[3] = y
	end
	def score1=(score)
		@game_state[4] = score
	end
	def score2=(score)
		@game_state[5] = score
	end	

end