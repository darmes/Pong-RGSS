#==============================================================================
# ** Scene Pong One Player
#------------------------------------------------------------------------------
#  This class performs scene processing
#==============================================================================
class Scene_Pong_One < Scene_Pong_Base
  #--------------------------------------------------------------------------
  # * Make Spriteset - determines the spriteset to make
  #--------------------------------------------------------------------------
  def make_spriteset
    return Spriteset_Pong_One.new
  end
end

#==============================================================================
# ** Scene Pong Two Player
#------------------------------------------------------------------------------
#  This class performs scene processing
#==============================================================================
class Scene_Pong_Two < Scene_Pong_Base
  #--------------------------------------------------------------------------
  # * Make Spriteset - determines the spriteset to make
  #--------------------------------------------------------------------------
  def make_spriteset
    return Spriteset_Pong_Two.new
  end
end

#==============================================================================
# ** Scene Pong Server
#------------------------------------------------------------------------------
#  This class performs scene processing
#==============================================================================
class Scene_Pong_Server < Scene_Pong_Base
  #--------------------------------------------------------------------------
  # * Make Spriteset - determines the spriteset to make
  #--------------------------------------------------------------------------
  def make_spriteset
    return Spriteset_Pong_Server.new
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    Console.log 'updating server game state...'
    $game_server.game_state = @spriteset.game_state
    Console.log 'updating server...'
    $game_server.update
  end
end

#==============================================================================
# ** Scene Pong Client
#------------------------------------------------------------------------------
#  This class performs scene processing
#==============================================================================
class Scene_Pong_Client < Scene_Pong_Base
  #--------------------------------------------------------------------------
  # * Make Spriteset - determines the spriteset to make
  #--------------------------------------------------------------------------
  def make_spriteset
    return Spriteset_Pong_Client.new
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    if Input.press?(Input::B)
      $scene = Scene_Title_Pong.new
    end
    $game_client.update
    @spriteset.game_state = $game_client.game_state
    @spriteset.update
  end
end