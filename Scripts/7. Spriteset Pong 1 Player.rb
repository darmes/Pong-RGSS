#==============================================================================
# ** Spriteset_Pong One
#------------------------------------------------------------------------------
#  This class brings together screen sprites
#==============================================================================

class Spriteset_Pong_One
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    # Make viewports
    @viewport1 = Viewport.new(0, 0, 640, 480)

    # Make enemy sprite
    @enemy = Sprite_Paddle.new(@viewport1)
    @enemy.x = 640 - @enemy.width - 15
    @enemy.y = (480 / 2 - @enemy.height / 2)
    # Make player sprite
    @player = Sprite_Paddle.new(@viewport1)
    @player.x = 15
    @player.y = (480 / 2 - @player.height / 2)
    # Make ball sprite
    @ball = Sprite_Ball.new(@viewport1)
    @ball.x = 640 / 2 - @ball.width / 2
    @ball.y = 480 / 2 - @ball.height / 2
    # Make score sprites
    @player_score_sprite = Sprite_Score.new(@viewport1)
    @player_score_sprite.x = 640 / 3 - @player_score_sprite.width / 2
    @player_score_sprite.y = 15
    @enemy_score_sprite = Sprite_Score.new(@viewport1)
    @enemy_score_sprite.x = 640 * 2 / 3 - @enemy_score_sprite.width / 2
    @enemy_score_sprite.y = 15
    # Make line sprite
    @line = Sprite_Line.new(@viewport1)
    
    # Make wait count
    @wait_count = 0
    # Make score counters
    @player_score = 0
    @enemy_score = 0
    
    # Reset
    reset
    # Frame update
    update
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def dispose
    # Dispose of enemy sprites and actor sprites
    @enemy.dispose
    @player.dispose
    # Dispose of ball
    @ball.dispose
    # Dispose of score sprites and line sprite
    @player_score_sprite.dispose
    @enemy_score_sprite.dispose
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
    # update player paddle
    @player.update
    # update enemy paddle
    @enemy.enemy_update(@ball)
    # if ball is touching either wall
    if @ball.y <= 0 or @ball.ey >= 480
      @ball.wall_bounce
    end
    # if ball is touching player paddle and moving towards it
    if @ball.x <= @player.ex and
       (@player.y...@player.ey).include?(@ball.y) and
			 @ball.x_vector < 0
				@ball.paddle_bounce
     end
     # if ball is touching enemy paddle and moving towards it
     if @ball.ex >= @enemy.x and
       (@enemy.y...@enemy.ey).include?(@ball.y) and
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
    if @player_score == 9
      print "You Win!"
      $scene = Scene_Title_Pong.new
    end
    if @enemy_score == 9
      print "You Lose!"
      $scene = Scene_Title_Pong.new
    end
    if @ball.x <= @player.x and
       not (@player.y...@player.ey).include?(@ball.y)
       @enemy_score += 1
       reset
    end
    if @ball.ex >= @enemy.ex and
      not (@enemy.y...@enemy.ey).include?(@ball.y)
      @player_score += 1
      reset
    end
  end
  #--------------------------------------------------------------------------
  # * Reset
  #--------------------------------------------------------------------------
  def reset
    @enemy.x = 640 - @enemy.width - 15
    @enemy.y = (480 / 2 - @enemy.height / 2)
    @player.x = 15
    @player.y = (480 / 2 - @player.height / 2)
    @ball.x = 640 / 2 - @ball.width / 2
    @ball.y = 480 / 2 - @ball.height / 2
    @ball.x_vector = rand(2) == 0 ? rand(2) + 2 : - rand(2) - 2
    @ball.y_vector = rand(2) == 0 ? rand(2) + 2 : - rand(2) - 2
    @player_score_sprite.set_score(@player_score)
    @enemy_score_sprite.set_score(@enemy_score)
    $start = true
    sleep(1)
  end
end
