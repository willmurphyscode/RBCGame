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
    debug_draw @window
  end

  def blocks_left?(mover_rectangle)
    mover_rectangle.blocked_left? rectangle
  end

  def blocks_right?(mover_rectangle)
    mover_rectangle.blocked_right? rectangle
  end

  def blocks_top?(mover_rectangle)
    mover_rectangle.blocked_down? rectangle
  end
end
