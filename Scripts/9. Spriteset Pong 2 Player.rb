#==============================================================================
# ** Spriteset_Pong One
#------------------------------------------------------------------------------
#  This class brings together screen sprites
#==============================================================================

class Spriteset_Pong_Two
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    # Make viewports
    @viewport1 = Viewport.new(0, 0, 640, 480)

    # Make player 1 sprite
    @player_1 = Sprite_Paddle.new(@viewport1)
    @player_1.x = 640 - @player_1.width - 15
    @player_1.y = (480 / 2 - @player_1.height / 2)
    # Make player 2 sprite
    @player_2 = Sprite_Paddle.new(@viewport1)
    @player_2.x = 15
    @player_2.y = (480 / 2 - @player_2.height / 2)
    # Make ball sprite
    @ball = Sprite_Ball.new(@viewport1)
    @ball.x = 640 / 2 - @ball.width / 2
    @ball.y = 480 / 2 - @ball.height / 2
    # Make score sprites
    @player_2_score_sprite = Sprite_Score.new(@viewport1)
    @player_2_score_sprite.x = 640 / 3 - @player_2_score_sprite.width / 2
    @player_2_score_sprite.y = 15
    @player_1_score_sprite = Sprite_Score.new(@viewport1)
    @player_1_score_sprite.x = 640 * 2 / 3 - @player_1_score_sprite.width / 2
    @player_1_score_sprite.y = 15
    # Make line sprite
    @line = Sprite_Line.new(@viewport1)
    
    # Make wait count
    @wait_count = 0
    # Make score counters
    @player_2_score = 0
    @player_1_score = 0
    
    # Reset
    reset
    # Frame update
    update
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def dispose
    # Dispose of player 1 & 2 paddles
    @player_1.dispose
    @player_2.dispose
    # Dispose of ball
    @ball.dispose
    # Dispose of score sprites and line sprite
    @player_1_score_sprite.dispose
    @player_2_score_sprite.dispose
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
    @player_1.update
    # update enemy paddle
    @player_2.update_2_player
    # if ball is touching either wall
    if @ball.y <= 0 or @ball.ey >= 480
      @ball.wall_bounce
    end
    # if ball is touching player 2 paddle
    if @ball.x <= @player_2.ex and
       (@player_2.y...@player_2.ey).include?(@ball.y)
       @ball.paddle_bounce
     end
     # if ball is touching player 1 paddle
     if @ball.ex >= @player_1.x and
       (@player_1.y...@player_1.ey).include?(@ball.y)
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
    # Decide if player 1 won
    if @player_1_score == 9
      print "Player 1 Win!"
      $scene = Scene_Title_Pong.new
    end
    # Decide if player 2 won
    if @player_2_score == 9
      print "Player 2 Win!"
      $scene = Scene_Title_Pong.new
    end
    # Decide if player 1 scored
    if @ball.x <= @player_2.x and
       not (@player_2.y...@player_2.ey).include?(@ball.y)
       @player_1_score += 1
       reset
    end
    # Decide if player 2 scored
    if @ball.ex >= @player_1.ex and
      not (@player_1.y...@player_1.ey).include?(@ball.y)
      @player_2_score += 1
      reset
    end
  end
  #--------------------------------------------------------------------------
  # * Reset
  #--------------------------------------------------------------------------
  def reset
    # Reset player 1 position
    @player_1.x = 640 - @player_1.width - 15
    @player_1.y = (480 / 2 - @player_1.height / 2)
    # Reset player 2 position
    @player_2.x = 15
    @player_2.y = (480 / 2 - @player_2.height / 2)
    # Reset ball position
    @ball.x = 640 / 2 - @ball.width / 2
    @ball.y = 480 / 2 - @ball.height / 2
    # Reset ball speed
    @ball.x_vector = rand(2) == 0 ? rand(2) + 2 : - rand(2) - 2
    @ball.y_vector = rand(2) == 0 ? rand(2) + 2 : - rand(2) - 2
    # Update player 1 score
    @player_1_score_sprite.set_score(@player_1_score)
    # Update player 2 score
    @player_2_score_sprite.set_score(@player_2_score)
    # Set start flag
    $start = true
    # Momentary pause
    sleep(1)
  end
# class end  
end
