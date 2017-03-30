class MoveDescriptor

  attr_accessor :x, :y, :direction, :moving, :jumping, :jump_count
  def initialize(ary)
    @x, @y, @moving, @direction, @jumping, @jump_count = ary
  end

  def self.initial_move(x, y)
    MoveDescriptor.new([x, y, false, :right, false, 0])
  end
end