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
    b_hash = { x_min: 9, x_max: 501, y_min: 10, y_max: 124 } # x coords overlap
    a = Rectangle.new a_hash
    b = Rectangle.new b_hash
    assert a.collides? b
  end

  def test_overlaps
    a_hash = { x_min: 5, x_max: 10, y_min: 0, y_max: 15 }
    a = Rectangle.new a_hash
    x = [0, 4]
    y = [1, 2]
    lows = [x.min, y.min]
    highs = [x.max, y.max]
    assert a.overlaps?(lows, highs), 'Overlapping range did not overlap'
  end

  def test_dont_overlap
    a_hash = { x_min: 5, x_max: 10, y_min: 0, y_max: 15 }
    a = Rectangle.new a_hash
    x = [0, 4]
    y = [6, 9]
    lows = [x.min, y.min]
    highs = [x.max, y.max]
    refute a.overlaps?(lows, highs), 'Non-overlapping range overlapped'
  end

  def test_blocked_down
    a_hash = { x_min: 5, x_max: 10, y_min: 100, y_max: 200 }
    a = Rectangle.new a_hash
    b_hash = { x_min: 5, x_max: 10, y_min: 50, y_max: 101 }
    b = Rectangle.new b_hash

    assert (b.blocked_down? (a)), 'expected rectangle to be blocked but it wasn\'t'
  end

  def test_not_blocked_down
    a_hash = { x_min: 5, x_max: 10, y_min: 200, y_max: 300 }
    a = Rectangle.new a_hash
    b_hash = { x_min: 5, x_max: 10, y_min: 50, y_max: 100 }
    b = Rectangle.new b_hash

    refute (b.blocked_down? (a)), 'expected rectangle not to be blocked but it was'
  end
end
