require 'minitest/autorun'
require_relative '../rectangle.rb'

class RectangleTest < Minitest::Test
  def test_non_collisions_dont_collide
    a_hash = { x_min: 5, x_max: 10, y_min: 0, y_max: 15 }
    b_hash = { x_min: 500, x_max: 501, y_min: 123, y_max: 124 }
    a = Rectangle.new a_hash
    b = Rectangle.new b_hash
    refute a.collides? b
  end

  def test_collision_collides
    a_hash = { x_min: 5, x_max: 10, y_min: 0, y_max: 15 }
    b_hash = { x_min: 9, x_max: 501, y_min: 123, y_max: 124 } # x coords overlap
    a = Rectangle.new a_hash
    b = Rectangle.new b_hash
    assert a.collides? b
  end
end
