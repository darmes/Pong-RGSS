#==============================================================================
# ** Game_Client
#------------------------------------------------------------------------------
#  This class handles the multiplayer client. Refer to $game_client for the
#  the instance of this class. This class works by streaming data on the
#  the state of the game from the Game Server class then passing that data to
#  the Spriteset. It sends input data (up or down) from the player back to
#  the server.
#==============================================================================

rgss_require_relative('Scripts/Game Scripts/Game Socket')

class GameClient < GameSocket

	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_reader :game_state
	#--------------------------------------------------------------------------
	# * Object Initialization
	#     hostname : dotted ip in string form
	#     port     : port number as integer
	#     defaults set by Mobius::Multiplayer
	#--------------------------------------------------------------------------
	def initialize(hostname = DEFAULT_HOSTNAME, port = DEFAULT_PORT)
		Console.log 'Creating socket...'
		create_socket(hostname, port)
		@request = ''
		@reply = ''
		@input_state = ''
		@game_state = {}
	end
	#--------------------------------------------------------------------------
	# * Create Socket - Creates and connects the socket to the server
	#--------------------------------------------------------------------------
	def create_socket(hostname, port)
		Thread.new do
			@socket = TCPSocket.new(hostname, port)
			Console.log 'socket connected'
		end
	end
	#--------------------------------------------------------------------------
	# * Frame Update
	#--------------------------------------------------------------------------
	def update
		# Every frame check for input and send to server
		if Input.press?(Input::UP)
			@input_state = "up"
		elsif Input.press?(Input::DOWN)
			@input_state = "down"
		else
			@input_state = ""
		end
		send_message( @input_state )
		# Every frame assume server is sending you data
		get_reply
		# Turn reply into game state data
		make_game_state
	end
	#--------------------------------------------------------------------------
	# * Make Game State - Create game state hash for passing to Spriteset
	#--------------------------------------------------------------------------
	def make_game_state
		arr = unpack_message(@reply)
		@game_state[:paddle_left_y]  = arr[0]
		@game_state[:paddle_right_y] = arr[1]
		@game_state[:ball_x]         = arr[2]
		@game_state[:ball_y]         = arr[3]
		@game_state[:score_left]     = arr[4]
		@game_state[:score_right]    = arr[5]
	end
	#--------------------------------------------------------------------------
	# * Close - Closes the connected socket
	#--------------------------------------------------------------------------
	def close
		@socket.close
	end

end