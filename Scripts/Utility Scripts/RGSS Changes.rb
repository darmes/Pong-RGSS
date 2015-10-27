#==============================================================================
# ** Viewport
#------------------------------------------------------------------------------
#  Add simple methods for getting Rect information
#==============================================================================

class Viewport
  # Get viewport x-position
  def x
    self.rect.x
  end
  # Get viewport y-position
  def y
    self.rect.y
  end
  # Get viewport width
  def width
    self.rect.width
  end
  # Get viewport height
  def height
    self.rect.height
  end
end