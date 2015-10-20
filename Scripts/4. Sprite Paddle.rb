#==============================================================================
# ** Sprite_Paddle
#------------------------------------------------------------------------------
#  This sprite is used to display the paddles
#==============================================================================

class Sprite_Paddle < Sprite_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    self.bitmap = Bitmap.new(20, 60)
    rect = self.bitmap.rect
    self.bitmap.fill_rect(rect, Color.new(255, 255, 255))
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
  # * Dispose
  #--------------------------------------------------------------------------
  def reset
    self.y = (self.viewport.height / 2) - (self.height / 2)
  end
  #--------------------------------------------------------------------------
  # * Ball Within Height? - determines whether the ball is within the
  #   height of the paddle
  #--------------------------------------------------------------------------
  def ball_within_height?(ball)
    (self.y...self.ey).include?(ball.y) or
    (self.y...self.ey).include?(ball.ey)
  end
    #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  # def update
  #   # if moving up
  #   if Input.press?(Input::UP)
  #     self.y -= 4 unless self.y <= 0
  #   end
  #   # if moving down
  #   if Input.press?(Input::DOWN)
  #     self.y += 4 unless self.ey >= 480
  #   end
  # end
  #--------------------------------------------------------------------------
  # * Frame Update 2
  #--------------------------------------------------------------------------
  # def update_2_player
  #   # if moving up
  #   if Input.press?(Input::SHIFT)
  #     self.y -= 4 unless self.y <= 0
  #   end
  #   # if moving down
  #   if Input.press?(Input::CTRL)
  #     self.y += 4 unless self.ey >= 480
  #   end
  # end
  #--------------------------------------------------------------------------
  # * Enemy Update
  #--------------------------------------------------------------------------
  # def enemy_update(ball)
  #   # if ball is moving away
  #   if ball.x_vector < 0
  #     # if above center
  #     if self.y < (480 / 2 - self.height / 2)
  #       self.y += 2 # move down
  #     # if below center
  #     elsif self.y > (480 / 2 - self.height / 2)
  #       self.y -= 2 # move up
  #     end
  #     return
  #   else # if ball is moving toward
  #     # if ball is above paddle and moving up
  #     if ball.cy < self.cy and ball.y_vector < 0
  #       self.y -= 4 unless self.y <= 0
  #     # if ball is above paddle and moving down
  #     elsif ball.cy < self.cy and ball.y_vector > 0
  #       self.y -= 2 unless self.y <= 0
  #     # if ball is below paddle and moving up
  #     elsif ball.cy > self.cy and ball.y_vector < 0
  #       self.y += 2 unless self.ey >= 480
  #     # if ball is below paddle and moving down
  #     elsif ball.cy > self.cy and ball.y_vector > 0
  #       self.y += 4 unless self.ey >= 480
  #     end
  #     return
  #   end
  # end
end

#==============================================================================
# ** Sprite_Paddle_Left
#------------------------------------------------------------------------------
#  This sprite is used to display the left player paddle
#==============================================================================

class Sprite_Paddle_Left < Sprite_Paddle
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #--------------------------------------------------------------------------
  def initialize(viewport, one_player = true)
    super(viewport)
    self.x = 15
    @one_player = one_player
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    if @one_player
      update_one_player
    else
      update_two_player
    end
  end
  #--------------------------------------------------------------------------
  # * Update when single player
  #--------------------------------------------------------------------------
  def update_one_player
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
  # * Update when two players
  #--------------------------------------------------------------------------
  def update_two_player
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
  # * Bouncing?
  #--------------------------------------------------------------------------
  def bouncing?(ball)
    # is left edge of ball touching/past right edge of paddle?
    ball.x <= self.ex and
    # is ball within the height of the paddle?
    ball_within_height?(ball) and
    # is ball moving toward the paddle?
    ball.x_vector < 0
  end
end

#==============================================================================
# ** Sprite_Paddle_Right
#------------------------------------------------------------------------------
#  This sprite is used to display the right player paddle
#==============================================================================

class Sprite_Paddle_Right < Sprite_Paddle
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    self.x = viewport.width - self.width - 15
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
  # * Bouncing?
  #--------------------------------------------------------------------------
  def bouncing?(ball)
    # is right edge of ball touching/past left edge of paddle?
    ball.ex >= self.x and
    # is ball within the height of the paddle?
    ball_within_height?(ball) and
    # is ball moving toward the paddle?
    ball.x_vector > 0
  end
end

#==============================================================================
# ** Sprite_Paddle_Enemy
#------------------------------------------------------------------------------
#  This sprite is used to display the right enemy paddle
#==============================================================================

class Sprite_Paddle_Enemy < Sprite_Paddle_Right
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #     ball     : sprite_ball
  #--------------------------------------------------------------------------
  def initialize(viewport, ball = nil)
    super(viewport)
    @ball = ball
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    # if ball is moving away
    if @ball.x_vector < 0
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
      if @ball.cy < self.cy and @ball.y_vector < 0
        self.y -= 4 unless self.y <= 0
        # if ball is above paddle and moving down
      elsif @ball.cy < self.cy and @ball.y_vector > 0
        self.y -= 2 unless self.y <= 0
        # if ball is below paddle and moving up
      elsif @ball.cy > self.cy and @ball.y_vector < 0
        self.y += 2 unless self.ey >= 480
        # if ball is below paddle and moving down
      elsif @ball.cy > self.cy and @ball.y_vector > 0
        self.y += 4 unless self.ey >= 480
      end
      return
    end
  end
end

#==============================================================================
# ** Sprite_Paddle_Client
#------------------------------------------------------------------------------
#  This sprite is used to display the right client paddle
#==============================================================================

class Sprite_Paddle_Client < Sprite_Paddle_Right
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    # if moving up
    if $game_server.reply == 'up'
      self.y -= 4 unless self.y <= 0
    end
    # if moving down
    if $game_server.reply == 'down'
      self.y += 4 unless self.ey >= 480
    end
  end
end