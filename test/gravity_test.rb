require 'minitest/autorun'
require_relative '../rectangle.rb'
require_relative '../gravity'

class FakeGameState
  def initialize(blocked = false)
    @blocked = blocked
  end

  def blocked_down?(_)
    @blocked
  end
end

class FakePlayer
  include Gravity

  def initialize(game_state)
    @y = 20
    @game_state = game_state
  end

  attr_reader :y
end

class GravityTest < Minitest::Test
  def test_not_blocked_falls
    sut = FakePlayer.new(FakeGameState.new(false))
    expected = 10
    sut.fall
    actual = sut.y
    assert_equal(expected, actual)
  end

  def test_blocked_doesnt_fall
    sut = FakePlayer.new(FakeGameState.new(true))
    expected = 20
    sut.fall
    actual = sut.y
    assert_equal(expected, actual)
  end
end
