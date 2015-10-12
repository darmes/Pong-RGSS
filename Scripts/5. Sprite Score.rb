#==============================================================================
# ** Sprite_Score
#------------------------------------------------------------------------------
#  This sprite is used to display the paddles
#==============================================================================

class Sprite_Score < Sprite
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
    self.z = 1
    set_score(0)
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
  #--------------------------------------------------------------------------
  # * height
  #--------------------------------------------------------------------------
  def height
    self.bitmap.height
  end
  #--------------------------------------------------------------------------
  # * width
  #--------------------------------------------------------------------------
  def width
    self.bitmap.width
  end
  #--------------------------------------------------------------------------
  # * cx - center x coordinate
  #        returns the x coordinate of the center of the sprite
  #--------------------------------------------------------------------------
  def cx
    self.x + width / 2
  end
  #--------------------------------------------------------------------------
  # * cy - center y coordinate
  #        returns the y coordinate of the center of the sprite
  #--------------------------------------------------------------------------
  def cy
    self.y + height / 2
  end
  #--------------------------------------------------------------------------
  # * ex - end x coordinate
  #        returns the x coordinate of the end of the sprite
  #--------------------------------------------------------------------------
  def ex
    self.x + width
  end
  #--------------------------------------------------------------------------
  # * ey - end y coordinate
  #        returns the y coordinate of the end of the sprite
  #--------------------------------------------------------------------------
  def ey
    self.y + height
  end
  #--------------------------------------------------------------------------
  # * set number 
  #--------------------------------------------------------------------------
  def set_score(num)
    case num
    when 0 ; self.bitmap = RPG::Cache.picture("Pong Zero")
    when 1 ; self.bitmap = RPG::Cache.picture("Pong One")
    when 2 ; self.bitmap = RPG::Cache.picture("Pong Two")
    when 3 ; self.bitmap = RPG::Cache.picture("Pong Three")
    when 4 ; self.bitmap = RPG::Cache.picture("Pong Four")
    when 5 ; self.bitmap = RPG::Cache.picture("Pong Five")
    when 6 ; self.bitmap = RPG::Cache.picture("Pong Six")
    when 7 ; self.bitmap = RPG::Cache.picture("Pong Seven")
    when 8 ; self.bitmap = RPG::Cache.picture("Pong Eight")
    when 9 ; self.bitmap = RPG::Cache.picture("Pong Nine")
    end
  end
end
