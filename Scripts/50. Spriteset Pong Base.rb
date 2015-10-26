#==============================================================================
# ** Spriteset_Pong Base
#------------------------------------------------------------------------------
#  This class brings together screen sprites
#==============================================================================

class Spriteset_Pong_Base
  #--------------------------------------------------------------------------
  # * Public Variables
  #--------------------------------------------------------------------------
  attr_accessor :game_state
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
    # Make Game State Hash
    @game_state = {}
    @game_state.default = 0
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
    # Make ball sprite
    @ball = Sprite_Ball.new(@viewport1)
    # Make left paddle
    @paddle_left = make_left_paddle
    # Make right paddle
    @paddle_right = make_right_paddle
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
    # if ball is bouncing off either paddle
    if @paddle_left.bouncing?(@ball) or @paddle_right.bouncing?(@ball)
      @ball.paddle_bounce
    end
    # update ball position
    @ball.move
    # increase wait count
    @wait_count += 1
    @ball.speed_up if @wait_count % 1000 == 0
    # update game state
    update_game_state
  end
  #--------------------------------------------------------------------------
  # * judge
  #--------------------------------------------------------------------------
  def judge
    if @score_left == 9
      left_win
    end
    if @score_right == 9
      right_win
    end
    if @ball.x <= @paddle_left.x and
      not @paddle_left.ball_within_height?(@ball)
        @score_right += 1
        reset
    end
    if @ball.ex >= @paddle_right.ex and
      not @paddle_right.ball_within_height?(@ball)
        @score_left += 1
        reset
    end
  end
  #--------------------------------------------------------------------------
  # * Left Win - called when left player wins
  #--------------------------------------------------------------------------
  def left_win
    print "Left Player Wins!"
    $scene = Scene_Title_Pong.new
  end
  #--------------------------------------------------------------------------
  # * Right Win - called when right player wins
  #--------------------------------------------------------------------------
  def right_win
    print "Right Player Wins!"
    $scene = Scene_Title_Pong.new
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
  #--------------------------------------------------------------------------
  # * Update Game State -- collects and stores important info for each object
  #--------------------------------------------------------------------------
  def update_game_state
    @game_state[:paddle_left_y]  = @paddle_left.y
    @game_state[:paddle_right_y] = @paddle_right.y
    @game_state[:ball_x]         = @ball.x
    @game_state[:ball_y]         = @ball.y
    @game_state[:score_left]     = @score_left
    @game_state[:score_right]    = @score_right
  end
  #--------------------------------------------------------------------------
  # * Update From Game State -- Uses game state to set objects
  #--------------------------------------------------------------------------
  def update_from_game_state
    @paddle_left.y  = @game_state[:paddle_left_y]
    @paddle_right.y = @game_state[:paddle_right_y]
    @ball.x         = @game_state[:ball_x]
    @ball.y         = @game_state[:ball_y]
    @score_left     = @game_state[:score_left]
    @score_right    = @game_state[:score_right]
  end
end
