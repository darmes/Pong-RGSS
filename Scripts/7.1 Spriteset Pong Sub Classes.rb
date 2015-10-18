#==============================================================================
# ** Spriteset_Pong One
#------------------------------------------------------------------------------
#  This class brings together screen sprites
#==============================================================================
class Spriteset_Pong_One < Spriteset_Pong_Base
  #--------------------------------------------------------------------------
  # * Makes the left paddle
  #--------------------------------------------------------------------------
  def make_left_paddle
    return Sprite_Paddle_Left.new(@viewport1, true)
  end
  #--------------------------------------------------------------------------
  # * Makes the right paddle
  #--------------------------------------------------------------------------
  def make_right_paddle
    return Sprite_Paddle_Enemy.new(@viewport1, @ball)
  end
  #--------------------------------------------------------------------------
  # * Left Win - called when left player wins
  #--------------------------------------------------------------------------
  def left_win
    print "You Win!"
    $scene = Scene_Title_Pong.new
  end
  #--------------------------------------------------------------------------
  # * Right Win - called when right player wins
  #--------------------------------------------------------------------------
  def right_win
    print "You Lost!"
    $scene = Scene_Title_Pong.new
  end
end

#==============================================================================
# ** Spriteset_Pong Two
#------------------------------------------------------------------------------
#  This class brings together screen sprites
#==============================================================================
class Spriteset_Pong_Two < Spriteset_Pong_Base
  #--------------------------------------------------------------------------
  # * Makes the left paddle
  #--------------------------------------------------------------------------
  def make_left_paddle
    return Sprite_Paddle_Left.new(@viewport1, false)
  end
  #--------------------------------------------------------------------------
  # * Makes the right paddle
  #--------------------------------------------------------------------------
  def make_right_paddle
    return Sprite_Paddle_Right.new(@viewport1)
  end
end