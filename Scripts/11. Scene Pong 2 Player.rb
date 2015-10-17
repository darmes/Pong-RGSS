#==============================================================================
# ** Scene_Pong Two Player
#------------------------------------------------------------------------------
#  This class performs scene processing
#==============================================================================

class Scene_Pong_Two
	#--------------------------------------------------------------------------
	# * Object Initialization
	#--------------------------------------------------------------------------
	def initialize(lan = false)
		@lan = lan
	end
  #--------------------------------------------------------------------------
  # * Main Processing
  #--------------------------------------------------------------------------
  def main
    $start = false
    # Set up
		if @lan
			@spriteset = Spriteset_Pong_Two_LAN.new
		else
			@spriteset = Spriteset_Pong_Two.new
		end
    # Transition run
    Graphics.transition
    # Main loop
    loop do
      # Update game screen
      Graphics.update
      if $start == true
        sleep(1)
        $start = false
      end
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
    
    # Dispose of graphics
    @spriteset.dispose
    
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    if Input.press?(Input::B)
      $scene = Scene_Title_Pong.new
    end
    @spriteset.update
  end
  

end
