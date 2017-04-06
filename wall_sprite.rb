class WallSprite
  include Occupies
  MAX_X = 675
  MIN_X = -35
  def initialize(window, hash = {})
    @window = window
    @width = hash[:width]
    @height = hash[:height]
    @x = hash[:x]
    @y = hash[:y]
    @image = Gosu::Image.load_tiles @window,
                                    'png/brick.png',
                                    @width, @height, true
  end

  def update
    # no op
  end

  def draw
    @image[1].draw @x, @y, 1
  end
end
