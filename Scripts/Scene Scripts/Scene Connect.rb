#==============================================================================
# ** Scene Connect
#------------------------------------------------------------------------------
#  This class performs connection processing.
#==============================================================================

class Scene_Connect < Scene_Base
  #--------------------------------------------------------------------------
  # * Main Processing
  #--------------------------------------------------------------------------
  def main
		# Initialize connection thread
		@connection_thread = nil
		# Initialize IP address
		@ip_address = ''
    # Make command window
    make_command_window
		# Make help window
    make_help_window
    # Execute transition
    Graphics.transition
    # Main loop
    loop do
      # Update game screen
      Graphics.update
      # Update input information
      Input.update
      # Frame update
      update
      # Abort loop if screen is changed
      if $scene != self
        break
      end
    end
    # Prepare for transition
    Graphics.freeze
    # Dispose of windows
		dispose_all_windows
	end
	#--------------------------------------------------------------------------
  # * Make Command Window
  #--------------------------------------------------------------------------
  def make_command_window
    s1                           = "Host"
    s2                           = "Client"
    s3                           = "Back"
    @command_window              = Window_Command.new(192, [s1, s2, s3])
    @command_window.back_opacity = 160
    @command_window.x            = 320 - @command_window.width / 2
    @command_window.y            = 288
  end
  #--------------------------------------------------------------------------
  # * Make Help Window
  #--------------------------------------------------------------------------
  def make_help_window
    @help_window = Window_Help.new
    @help_window.set_text("Are you host or client?", 1)
	end
	#--------------------------------------------------------------------------
	# * Dispose All Windows
	#--------------------------------------------------------------------------
	def dispose_all_windows
		@command_window.dispose
		@help_window.dispose
	end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
		# Update all windows
		update_all_windows
    # Check if connecting, if so then wait
		if connecting?
			update_connecting_to_client
			return
		end
		# Check if inputting IP address
		unless @command_window.active
			update_ip_input
			return
		end
		# Update Command
		update_command
	end
	#--------------------------------------------------------------------------
	# * Update All Windows
	#--------------------------------------------------------------------------
	def update_all_windows
		# Update help window
		@help_window.update
		# Update command window
		@command_window.update
	end
	#--------------------------------------------------------------------------
	# * Update Connecting To Client
	#--------------------------------------------------------------------------
	def update_connecting_to_client
		Console.log 'connection thread is running...'
		# If B button was pressed
		if Input.trigger?(Input::B)
			# Kill thread
			@connection_thread.kill
			# Close server gracefully
			$game_server.close
			# Re-initialize variable
			@connection_thread = nil
			# Re-activate command window
			@command_window.active = true
		end
	end
	#--------------------------------------------------------------------------
	# * Update IP Input
	#--------------------------------------------------------------------------
	def update_ip_input
		# If B button was pressed
		if Input.trigger?(Input::B)
			play_cancel_se
			@command_window.active = true
			@help_window.set_text("Are you host or client?", 1)
			@ip_address = ''
			return
		end
		# Get input
		get_ip_input
		# Update help window
		update_ip_text
		# If C button was pressed
		if Input.trigger?(Input::C)
			# Connect to server
			establish_connection_with_server
		end
	end
	#--------------------------------------------------------------------------
	# * Get IP Input
	#--------------------------------------------------------------------------
	def get_ip_input
		# If BKSP is pressed
		if Input.ktrigger?(8)
			remove_ip_character
		end
		# If . is pressed
		if Input.ktrigger?(190)
			add_ip_character('.')
		end
		# If numbers 0-9 are pressed
		for i in 48...58
			if Input.ktrigger?(i)
				add_ip_character(i - 48)
			end
		end
		# If num keys 0-9 are pressed
		for i in 96...106
			if Input.ktrigger?(i)
				add_ip_character(i - 96)
			end
		end
	end
	#--------------------------------------------------------------------------
	# * Update IP Text
	#--------------------------------------------------------------------------
	def update_ip_text
		help_text = 'Enter the host\'s IP Address: ' + @ip_address
		@help_window.set_text(help_text)
	end
	#--------------------------------------------------------------------------
	# * Add IP Character
	#--------------------------------------------------------------------------
	def add_ip_character(char)
		@ip_address << char.to_s
	end
	#--------------------------------------------------------------------------
	# * Remove IP Character
	#--------------------------------------------------------------------------
	def remove_ip_character
		@ip_address.chop!
	end
	#--------------------------------------------------------------------------
	# * Update Command - branch by input in command window
	#--------------------------------------------------------------------------
	def update_command
		# If C button was pressed
		if Input.trigger?(Input::C)
			# Branch by command window cursor position
			case @command_window.index
				when 0 # Host
					command_host
				when 1 # Client
					command_client
				when 2 # Back
					command_back
			end
		end
		# If B button was pressed
		if Input.trigger?(Input::B)
			command_back
		end
	end
	#--------------------------------------------------------------------------
	# * Command: Base
	#--------------------------------------------------------------------------
	def command_base
		# Play decision SE
		play_decision_se
		# Deactivate command window
		@command_window.active = false
	end
	#--------------------------------------------------------------------------
  # * Command: Host
  #--------------------------------------------------------------------------
  def command_host
		# Call common method
    command_base
		# Connect to client
		establish_connection_with_client
	end
  #--------------------------------------------------------------------------
  # * Command: Client
  #--------------------------------------------------------------------------
  def command_client
		# Call common method
		command_base
		# Set help text
		@help_window.set_text('Enter the host\'s IP Address: ')
  end
  #--------------------------------------------------------------------------
  # * Command: Back
  #--------------------------------------------------------------------------
  def command_back
		# Call common method
		command_base
    # Switch to game screen
    $scene = Scene_Title_Pong.new
  end
	#--------------------------------------------------------------------------
	# * Establish Connection with Client
	#--------------------------------------------------------------------------
	def establish_connection_with_client
		# Update help message
		@help_window.set_text("Waiting for client to connect...", 1)
		Console.log "creating server"
		# Create Server
		$game_server = GameServer.new
		@connection_thread = Thread.new do
			Console.log "waiting for client..."
			sleep(1)
			$game_server.accept
			# @connection_thread = nil
			$scene = Scene_Pong_Server.new
		end
		# Make current thread have higher priority
		Thread.current.priority = 2
		Console.log "Thread is running, returning to normal update cycle"
	end
	#--------------------------------------------------------------------------
	# * Establish Connection with Server
	#--------------------------------------------------------------------------
	def establish_connection_with_server
	  $game_client = GameClient.new
    $scene = Scene_Pong_Client.new
  end
	#--------------------------------------------------------------------------
	# * Connecting? - return whether the process is trying to connect
	#--------------------------------------------------------------------------
	def connecting?
		return @connection_thread
	end
end
