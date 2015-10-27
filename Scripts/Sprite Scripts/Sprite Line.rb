#==============================================================================
# ** Sprite_Line
#------------------------------------------------------------------------------
#  This sprite is used to display the paddles
#==============================================================================

rgss_require_relative('Scripts/Sprite Scripts/Sprite Base')

class Sprite_Line < Sprite_Base
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------

  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #     battler  : battler (Game_Battler)
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    self.bitmap = RPG::Cache.picture("Pong Line")
    self.x = 640 / 2 - width / 2
    self.y = -7
    self.z = 1
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def dispose
    if self.bitmap != nil
      self.bitmap.dispose
    end
    super
  end
end
