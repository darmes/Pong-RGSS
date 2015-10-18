#==============================================================================
# ** Scene Connect
#------------------------------------------------------------------------------
#  This class performs connection processing.
#==============================================================================

class Scene_Connect
  #--------------------------------------------------------------------------
  # * Main Processing
  #--------------------------------------------------------------------------
  def main
		# Initialize connection thread
		@connection_thread = nil
		
    # Make command window
    s1 = "Host"
    s2 = "Client"
    s3 = "Back"
    @command_window = Window_Command.new(192, [s1, s2, s3])
    @command_window.back_opacity = 160
    @command_window.x = 320 - @command_window.width / 2
    @command_window.y = 288
		# Make help window
		@help_window = Window_Help.new
		@help_window.set_text("Are you host or client?", 1)
		
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
    @command_window.dispose
		@help_window.dispose
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
		# Update help window
		@help_window.update
		# Update command window
    @command_window.update
    # Check if connecting, if so then wait
		if connecting?
			Console.log "other thread is running..."
			if Input.trigger?(Input::B)				
				@connection_thread.kill
				$game_server.close
				@connection_thread = nil
			end
			return
		end				
    # If C button was pressed
    if Input.trigger?(Input::C)
      # Branch by command window cursor position
      case @command_window.index
      when 0  # Host
        command_host
      when 1  # Client
        command_client
      when 2  # Back
        command_back
      end
    end
		if Input.trigger?(Input::B)
			command_back
		end
  end
  #--------------------------------------------------------------------------
  # * Command: Host
  #--------------------------------------------------------------------------
  def command_host
    # Play decision SE
    $game_system.se_play($data_system.decision_se)
		# Connect to client
		establish_connection_with_client
    
    # Switch to game screen
    # $scene = Scene_Pong_Two.new(true, true)
	end
  #--------------------------------------------------------------------------
  # * Command: Client
  #--------------------------------------------------------------------------
  def command_client
    # Play decision SE
    $game_system.se_play($data_system.decision_se)
    # Create Client
		$game_client = GameClient.new
    # Switch to game screen
    $scene = Scene_Pong_Two.new(true, false)
  end
  #--------------------------------------------------------------------------
  # * Command: Back
  #--------------------------------------------------------------------------
  def command_back
    # Play decision SE
    $game_system.se_play($data_system.decision_se)
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
			$scene = Scene_Pong_Two.new(true, true)
		end
		Thread.current.priority = 10
		Console.log "Thread is running, returning to normal update cycle"
	end
	#--------------------------------------------------------------------------
	# * Establish Connection with Server
	#--------------------------------------------------------------------------
	def establish_connection_with_server
	
	end
	#--------------------------------------------------------------------------
	# * Connecting? - return whether the process is trying to connect
	#--------------------------------------------------------------------------
	def connecting?
		return @connection_thread
	end
end
