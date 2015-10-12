#==============================================================================
# ** Sprite_Paddle
#------------------------------------------------------------------------------
#  This sprite is used to display the paddles
#==============================================================================

class Sprite_Paddle < Sprite_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #     battler  : battler (Game_Battler)
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    self.bitmap = Bitmap.new(20, 60)
    rect = self.bitmap.rect
    self.bitmap.fill_rect(rect, Color.new(255, 255, 255))
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
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    # if moving up
    if Input.press?(Input::UP)
      self.y -= 4 unless self.y <= 0
    end
    # if moving down
    if Input.press?(Input::DOWN)
      self.y += 4 unless self.ey >= 480
    end
  end
  #--------------------------------------------------------------------------
  # * Frame Update 2
  #--------------------------------------------------------------------------
  def update_2_player
    # if moving up
    if Input.press?(Input::SHIFT)
      self.y -= 4 unless self.y <= 0
    end
    # if moving down
    if Input.press?(Input::CTRL)
      self.y += 4 unless self.ey >= 480
    end
  end
  #--------------------------------------------------------------------------
  # * Enemy Update
  #--------------------------------------------------------------------------
  def enemy_update(ball)
    # if ball is moving away
    if ball.x_vector < 0
      # if above center
      if self.y < (480 / 2 - self.height / 2)
        self.y += 2 # move down
      # if below center
      elsif self.y > (480 / 2 - self.height / 2)
        self.y -= 2 # move up
      end
      return
    else # if ball is moving toward
      # if ball is above paddle and moving up
      if ball.cy < self.cy and ball.y_vector < 0
        self.y -= 4 unless self.y <= 0
      # if ball is above paddle and moving down
      elsif ball.cy < self.cy and ball.y_vector > 0
        self.y -= 2 unless self.y <= 0
      # if ball is below paddle and moving up
      elsif ball.cy > self.cy and ball.y_vector < 0
        self.y += 2 unless self.ey >= 480
      # if ball is below paddle and moving down
      elsif ball.cy > self.cy and ball.y_vector > 0
        self.y += 4 unless self.ey >= 480
      end
      return
    end
  end
end
