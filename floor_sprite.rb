class FloorSprite
  MAX_X = 675
  MIN_X = -35
  def initialize window
    @window = window
    @width = @height = 160
    @floor = Gosu::Image.load_tiles @window,
                                   "png/brick.png",
                                   @width, @height, true
  end

  def update 
    # no op 
  end 

  def draw 
    @floor[1].draw 0, 420, 1
  end 
end