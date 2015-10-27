#==============================================================================
# ** Game_Server
#------------------------------------------------------------------------------
#  This class handles the multiplayer server. Refer to $game_server for the
#  the instance of this class. This class works by collecting data on the
#  the state of the game from the Spriteset class then streaming that data to
#  the client. It collects input data (up or down) from the client and passes
#  that back to the Spriteset.
#==============================================================================

class GameServer < GameSocket

	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_reader :reply
	#--------------------------------------------------------------------------
	# * Object Initialization
	#     hostname : dotted ip in string form
	#     port     : port number as integer
	#     defaults set by Mobius::Multiplayer
	#--------------------------------------------------------------------------
	def initialize(hostname = DEFAULT_HOSTNAME, port = DEFAULT_PORT)
		@server = TCPServer.new(hostname, port)
		@socket = nil
		@request = ""
		# Initialize reply to nil
		@reply = nil
		# Create empty game_state array initialized to 0's
		@game_state = Array.new(6, 0) 
	end
	#--------------------------------------------------------------------------
	# * Accept - Sets server to wait for incoming connection
	#--------------------------------------------------------------------------
	def accept
			@server.listen(1)
			@socket = @server.accept
			Console.log "Connected to #{@socket}"
	end
	#--------------------------------------------------------------------------
	# * Close - Closes the server and connected socket
	#--------------------------------------------------------------------------
	def close
		@server.close
		@socket.close unless @socket.nil?
	end
	#--------------------------------------------------------------------------
	# * Frame Update
	#--------------------------------------------------------------------------
	def update
		# Every frame assume @game_state is good and send to client
		send_message( pack_message(@game_state) )
		# Every frame assume client is sending you data
		get_reply
	end
	#--------------------------------------------------------------------------
	# * Game State = - Uses the game state hash from the Spriteset class to
	#			update the server's game state array
	#--------------------------------------------------------------------------
	def game_state=(game_state_hash)
		@game_state[0]  =  game_state_hash[:paddle_left_y]
		@game_state[1]  =  game_state_hash[:paddle_right_y]
		@game_state[2]  =  game_state_hash[:ball_x]
		@game_state[3]  =  game_state_hash[:ball_y]
		@game_state[4]  =  game_state_hash[:score_left]
		@game_state[5]  =  game_state_hash[:score_right]
	end

end