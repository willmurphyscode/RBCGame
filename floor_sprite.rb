class FloorSprite
  MAX_X = 675
  MIN_X = -35
  def initialize(window)
    @window = window
    @width = 800
    @height = 120
    @floor = Gosu::Image.load_tiles @window,
                                    'png/brick.png',
                                    @width, @height, true
  end

  def update
    # no op
  end

  def draw
    @floor[1].draw 0, 550, 1
  end
end
