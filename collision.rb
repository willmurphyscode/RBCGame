class Collision
  attr_accessor :wall, :player, :edge

  def initialize(hash)
    self.wall = hash[:wall]
    self.player = hash[:player]
  end

  def blocked_left?; end

  def blocked_right?; end

  def blocked_down?; end

  def blocked_up?; end
end
