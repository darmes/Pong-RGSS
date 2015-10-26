#==============================================================================
# ** Sprite_Ball
#------------------------------------------------------------------------------
#  This sprite is used to display the paddles
#==============================================================================

class Sprite_Ball < Sprite_Base
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor  :x_vector                 # x_vector 
  attr_accessor  :y_vector                 # y_vector
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #     battler  : battler (Game_Battler)
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    self.bitmap = Bitmap.new(20, 20)
    rect = self.bitmap.rect
    self.bitmap.fill_rect(rect, Color.new(255, 255, 255))
    self.z = 1000
    reset
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
  # * paddle bounce
  #--------------------------------------------------------------------------
  def paddle_bounce
    @x_vector = (@x_vector * -1)
    Audio.se_play("Audio/SE/Pong_hit", 75, 110)
  end
  #--------------------------------------------------------------------------
  # * wall bounce
  #--------------------------------------------------------------------------
  def wall_bounce
    @y_vector = (@y_vector * -1)
    Audio.se_play("Audio/SE/Pong_hit", 75, 110)
  end
  #--------------------------------------------------------------------------
  # * move
  #--------------------------------------------------------------------------
  def move
    self.x += @x_vector
    self.y += @y_vector
  end
  #--------------------------------------------------------------------------
  # * speed up
  #--------------------------------------------------------------------------
  def speed_up
    @x_vector > 0 ? @x_vector += 1 : @x_vector -= 1
    @y_vector > 0 ? @y_vector += 1 : @y_vector -= 1
  end
  #--------------------------------------------------------------------------
  # * reset
  #--------------------------------------------------------------------------
  def reset
    self.x = (viewport.width  / 2) - (self.width  / 2)
    self.y = (viewport.height / 2) - (self.height / 2)
    self.x_vector = rand(2) == 0 ? rand(2) + 2 : - rand(2) - 2
    self.y_vector = rand(2) == 0 ? rand(2) + 2 : - rand(2) - 2
  end
end
