#==============================================================================
# ** Scene_Pong One Player
#------------------------------------------------------------------------------
#  This class performs scene processing
#==============================================================================

class Scene_Pong_Two
  #--------------------------------------------------------------------------
  # * Main Processing
  #--------------------------------------------------------------------------
  def main
    $start = false
    # Set up
    @spriteset = Spriteset_Pong_Two.new
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
