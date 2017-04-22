module Momentum
  attr_accessor :x_vec, :y_vec
  def initialize(*)
    self.x_vec = 0
    self.y_vec = 0
  end
  def update!(game_state, mover)
    # TODO check collision
    old_x = @x
    old_y = @y
    @x = @x + x_vec
    @y = @y + y_vec
    a = mover.rectangle.clearance_left game_state
    b = mover.rectangle.clearance_right game_state
  end

  def max_x_vec(game_state)

  end

  def max_y_vec(game_state)

  end
end