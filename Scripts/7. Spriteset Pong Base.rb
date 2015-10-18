#==============================================================================
# ** Spriteset_Pong Base
#------------------------------------------------------------------------------
#  This class brings together screen sprites
#==============================================================================

class Spriteset_Pong_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    # Make viewports
    make_viewports
    # Make all sprites
    make_sprites
    # Make wait count
    @wait_count = 0
    # Make score counters
    @score_left = 0
    @score_right = 0
    # Reset
    reset
    # Frame update
    update
  end
  #--------------------------------------------------------------------------
  # * Make Viewports
  #--------------------------------------------------------------------------
  def make_viewports
    @viewport1 = Viewport.new(0, 0, 640, 480)
  end
  #--------------------------------------------------------------------------
  # * Make Sprites
  #--------------------------------------------------------------------------
  def make_sprites
    # Make left paddle
    @paddle_left = make_left_paddle
    # Make right paddle
    @paddle_right = make_right_paddle
    # Make ball sprite
    @ball = Sprite_Ball.new(@viewport1)
    # Make score sprites
    @score_left_sprite  = Sprite_Score_Left.new(@viewport1)
    @score_right_sprite = Sprite_Score_Right.new(@viewport1)
    # Make line sprite
    @line = Sprite_Line.new(@viewport1)
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def dispose
    # Dispose of paddle sprites
    @paddle_left.dispose
    @paddle_right.dispose
    # Dispose of ball
    @ball.dispose
    # Dispose of score sprites and line sprite
    @score_left_sprite.dispose
    @score_right_sprite.dispose
    @line.dispose
    # Dispose of viewports
    @viewport1.dispose
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    # judge
    judge
    # update left paddle
    @paddle_left.update
    # update right paddle
    @paddle_right.update
    # if ball is touching either wall
    if @ball.y <= 0 or @ball.ey >= @viewport1.height
      @ball.wall_bounce
    end
    # if ball is touching left paddle and moving towards it
    if @ball.x <= @paddle_left.ex and
        (@paddle_left.y...@paddle_left.ey).include?(@ball.y) and
        @ball.x_vector < 0
      @ball.paddle_bounce
    end
    # if ball is touching right paddle and moving towards it
    if @ball.ex >= @paddle_right.x and
        (@paddle_right.y...@paddle_right.ey).include?(@ball.y) and
        @ball.x_vector > 0
      @ball.paddle_bounce
    end
    # update ball position
    @ball.move
    # increase wait count
    @wait_count += 1
    @ball.speed_up if @wait_count % 1000 == 0
  end
  #--------------------------------------------------------------------------
  # * judge
  #--------------------------------------------------------------------------
  def judge
    if @score_left == 9
      print "You Win!"
      $scene = Scene_Title_Pong.new
    end
    if @score_right == 9
      print "You Lose!"
      $scene = Scene_Title_Pong.new
    end
    if @ball.x <= @paddle_left.x and
        not (@paddle_left.y...@paddle_left.ey).include?(@ball.y)
      @score_right += 1
      reset
    end
    if @ball.ex >= @paddle_right.ex and
        not (@paddle_right.y...@paddle_right.ey).include?(@ball.y)
      @score_left += 1
      reset
    end
  end
  #--------------------------------------------------------------------------
  # * Reset
  #--------------------------------------------------------------------------
  def reset
    @paddle_right.reset
    @paddle_left.reset
    @ball.reset
    @score_left_sprite.set_score(@score_left)
    @score_right_sprite.set_score(@score_right)
    $start = true
    sleep(1)
  end
end
