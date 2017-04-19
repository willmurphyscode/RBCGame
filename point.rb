class Point
  attr_accessor :x, :y
  def initialize(hash = {})
    self.x = hash[:x]
    self.y = hash[:y]
  end
end