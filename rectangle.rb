module Occupies
  def x_min
    @x
  end

  def y_min
    @y
  end

  def x_max
    @x + @width
  end

  def y_max
    @y + @height
  end

  def rectangle
    Rectangle.new x_min: x_min, x_max: x_max, y_min: y_min, y_max: y_max
  end

  def debug_draw(window)
    return unless DEBUG_DRAW

    color = Gosu::Color.argb(0xffff00ff)
    # from the Gosu docs:
    # draw_line(x1, y1, c1, x2, y2, c2, z = 0, mode = :default) ==> void
    window.draw_line(x_min, y_min, color, x_min, y_max, color)
    window.draw_line(x_max, y_min, color, x_max, y_max, color)
    window.draw_line(x_min, y_max, color, x_max, y_max, color)
    window.draw_line(x_min, y_min, color, x_max, y_min, color)
  end
end

class Rectangle
  attr_reader :x_min, :x_max, :y_min, :y_max
  def initialize(hash)
    @x_min = hash[:x_min]
    @x_max = hash[:x_max]
    @y_min = hash[:y_min]
    @y_max = hash[:y_max]
  end

  def collides?(other)
    (between?(other.x_min, x_min, x_max) || between?(other.x_max, x_min, x_max)) &&
      overlaps?([other.y_min, y_min], [other.y_max, y_max])
  end

  def blocked_left?(other)
    collides?(other) && other.x_min < @x_max
  end

  def blocked_right?(other)
    collides?(other) && other.x_max > @x_min
  end

  def blocked_down?(other)
    overlaps?([other.x_min, x_min], [other.x_max, x_max]) &&
        (between?(other.y_min, y_min, y_max) || between?(other.y_max, y_min, y_max))
  end

  def blocked_up?(_other)
    raise NotImplementedError
  end

  def between?(candidate, low, high)
    (low <= candidate && candidate <= high) || (high <= candidate && candidate <= low)
  end

  def overlaps?(lows, highs)
    lows.max <= highs.min
  end
end
