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

  MAX_DISTANCE = 10000

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
     #   (overlaps?([other.y_min, y_min], [other.y_max, y_max]))
      (touches?([other.y_min, y_min], [other.y_max, y_max]))
     # (between?(-other.y_min, -y_min, -y_max) || between?(-other.y_max, -y_min, -y_max))
  end

  def blocked_up?(_other)
    raise NotImplementedError
  end

  def between?(candidate, low, high)
    (low <= candidate && candidate < high) || (high < candidate && candidate < low)
  end

  def overlaps?(lows, highs)
    lows.max <= highs.min
  end

  def touches?(lows, highs)
    (lows.max - 1) <= highs.min
  end

  def clearance_left(game_state)
    nearest = wall_rectangles(game_state)
              .select { |r| r.on_horizontal_vector(self) }
              .sort { |r| self.left_dist(r) }
              .first
    result = nearest.nil? ? MAX_DISTANCE : left_dist(nearest)
    result
  end

  def clearance_right(game_state)
    nearest = wall_rectangles(game_state)
                  .select { |r| r.on_horizontal_vector(self) }
                  .sort { |r| self.right_dist(r) }
                  .first
    result = nearest.nil? ? MAX_DISTANCE : right_dist(nearest)
    result
  end

  def clearance_up(game_state)

  end

  def clearance_down(game_state)

  end

  def wall_rectangles(game_state)
    game_state.walls.collect { |w| w.rectangle }
  end

  def on_horizontal_vector(other)
    lows = [self.y_min, other.y_min]
    highs = [self.y_max, other.y_max]
    overlaps?(lows, highs)
  end

  def left_dist(other)
    other.x_max - self.x_min
  end

  def right_dist(other)
    self.x_max - other.x_min
  end
end
