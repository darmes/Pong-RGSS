#==============================================================================
# ** Scene_Title_Pong
#------------------------------------------------------------------------------
#  This class performs title screen processing.
#==============================================================================

rgss_require_relative('Scripts/Scene Scripts/Scene Base')

class Scene_Title_Pong < Scene_Base
  #--------------------------------------------------------------------------
  # * Main Processing
  #--------------------------------------------------------------------------
  def main
    # Load data system
    $data_system        = load_data("Data/System.rxdata")
    # Make system object
    $game_system = Game_System.new
    # Make title graphic
    @sprite = Sprite.new
    @sprite.bitmap = RPG::Cache.title($data_system.title_name)
    # Make command window
    s1 = "One Player"
    s2 = "Local Two Player"
    s3 = "LAN Two Player"
    s4 = "Shutdown"
    @command_window = Window_Command.new(192, [s1, s2, s3, s4])
    @command_window.back_opacity = 160
    @command_window.x = 320 - @command_window.width / 2
    @command_window.y = 288

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
    # Dispose of command window
    @command_window.dispose
    # Dispose of title graphic
    @sprite.bitmap.dispose
    @sprite.dispose
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    # Update command window
    @command_window.update
    # If C button was pressed
    if Input.trigger?(Input::C)
      # Branch by command window cursor position
      case @command_window.index
      when 0  # One Player
        command_one_player
      when 1  # Local Two Player
        command_two_player
      when 2  # LAN Two Player
        command_two_player_LAN
      when 3  # Shutdown
        command_shutdown
      end
    end
  end
  #--------------------------------------------------------------------------
  # * Command: One Player
  #--------------------------------------------------------------------------
  def command_one_player
    # Play decision SE
    $game_system.se_play($data_system.decision_se)
    # Reset frame count for measuring play time
    Graphics.frame_count = 0
    # Switch to game screen
    $scene = Scene_Pong_One.new
    end
  #--------------------------------------------------------------------------
  # * Command: Two Player
  #--------------------------------------------------------------------------
  def command_two_player
    # Play decision SE
    $game_system.se_play($data_system.decision_se)
    # Reset frame count for measuring play time
    Graphics.frame_count = 0
    # Switch to game screen
    $scene = Scene_Pong_Two.new
  end
	#--------------------------------------------------------------------------
  # * Command: Two Player LAN
  #--------------------------------------------------------------------------
  def command_two_player_LAN
    # Play decision SE
    $game_system.se_play($data_system.decision_se)
    # Reset frame count for measuring play time
    Graphics.frame_count = 0
    # Switch to game screen
    $scene = Scene_Connect.new
  end
  #--------------------------------------------------------------------------
  # * Command: Shutdown
  #--------------------------------------------------------------------------
  def command_shutdown
    # Shutdown
    $scene = nil
  end

end
