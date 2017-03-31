module Occupies
  def rectangle
    Rectangle.new  x_min: @x, x_max: @x + @width, y_min: @y, y_max: @y + @height 
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

  def collides? (other)
    between?(other.x_min, x_min, x_max) || between?(other.x_max, x_min, x_max)
  end

  def between? candidate, low, high
    (low <= candidate && candidate <= high) || (high <= candidate && candidate <= low)
  end
end